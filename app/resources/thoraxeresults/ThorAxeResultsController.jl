module ThorAxeResultsController

import Genie.Router: @params
import Genie.Renderer.Json: json
using Genie.Renderer.Html

using DataStructures
using Glob

const THORAXE_RESULTS_PATH = abspath("@__FILE__/../public/data/thoraxe")
const RNASEQ_PLOTS_PATH = abspath("@__FILE__/../public/data/rnaseq/plots")

struct ThorAxeResult
    path::String
    name::String
end

function get_thoraxe_results()
    paths = Glob.glob("*/thoraxe", THORAXE_RESULTS_PATH)
    @show paths
    results = OrderedDict{String, ThorAxeResult}()
    for path in paths
        name = splitpath(path)[end-1]
        results[name] = ThorAxeResult(path, name)
    end
    results
end

const THORAXE_RESULTS = get_thoraxe_results()

function get_rnaseq_plots()
    paths = Glob.glob("*/*.svg", RNASEQ_PLOTS_PATH)
    plots = OrderedDict{String, Vector{String}}()
    for path in paths
        folders = splitpath(path)
        data_pos = findfirst(==("data"), folders)
        genename = folders[end-1]
        path_to_data = join(folders[data_pos:end], '/')
        if haskey(plots, genename)
            push!(plots[genename], path_to_data)
        else
            plots[genename] = String[path_to_data]
        end
    end
    plots
end

const RNASEQ_PLOTS = get_rnaseq_plots()

function get_cytoscape_elements(selected_gene)
    splice_graph_file = joinpath(THORAXE_RESULTS[selected_gene].path, "splice_graph.gml")
    open(splice_graph_file, "r") do file
        elements = Dict{String,Dict{String,Any}}[]
        id2label = Dict{String, String}()
        type = ""
        id = ""
        label = ""
        source = ""
        target = ""
        transcript_fraction = 0.0
        conservation = 0.0
        transcript_weighted_conservation = 0.0
        for line in eachline(file)
            if occursin("node [", line)
                type = "node"
            elseif occursin("edge [", line)
                type = "edge"
            elseif occursin("id ", line)
                id = replace(split(line, ' ')[end], "\"" => "")
            elseif occursin("label ", line)
                label = replace(split(line, ' ')[end], "\"" => "")
                id2label[id] = label
            elseif occursin("transcript_fraction ", line)
                transcript_fraction = parse(Float64, split(line, ' ')[end])
            elseif occursin("conservation ", line)
                conservation = parse(Float64, split(line, ' ')[end])
            elseif occursin("transcript_weighted_conservation ", line)
                transcript_weighted_conservation = parse(Float64, split(line, ' ')[end])
            elseif occursin("source ", line)
                source = replace(split(line, ' ')[end], "\"" => "")
            elseif occursin("target ", line)
                target = replace(split(line, ' ')[end], "\"" => "")
            elseif occursin("]", line)
                if type == "edge"
                    push!(elements, Dict("data" => Dict(
                        "id" => id2label[source] * "->" * id2label[target],
                        "source" => source,
                        "target" => target,
                        "transcript_fraction" => transcript_fraction,
                        "conservation" => conservation,
                        "transcript_weighted_conservation" => transcript_weighted_conservation
                        )))
                end
                if type == "node"
                    push!(elements, Dict("data" => Dict(
                        "id" => id, 
                        "label" => label,
                        "transcript_fraction" => transcript_fraction,
                        "conservation" => conservation
                        )))
                end
                type = ""
                id = ""
                label = ""
                source = ""
                target = ""
                transcript_fraction = 0.0
                conservation = 0.0
                transcript_weighted_conservation = 0.0
            end
        end
        elements
    end
end

function read_msas(selected_gene)
    msa_paths = Glob.glob("msa/*.fasta", THORAXE_RESULTS[selected_gene].path)
    msas = OrderedDict{String, String}()
    for path in msa_paths
        file = splitpath(path)[end]
        s_exon_id = replace(replace(file, "msa_s_exon_" => ""), ".fasta" => "")
        msas[s_exon_id] = read(path, String)
    end
    msas
end

function load_gene(selected_gene)
    json(
        if selected_gene != ""
            Dict("selected_gene" => selected_gene,
                "cytoscape_elements" => get_cytoscape_elements(selected_gene),
                "rnaseq_plots" => get(RNASEQ_PLOTS, selected_gene, String[]),
                "s_exon_table" => read(joinpath(THORAXE_RESULTS[selected_gene].path, "s_exon_table.csv"), String),
                "ases_table" => read(joinpath(THORAXE_RESULTS[selected_gene].path, "ases_table.csv"), String),
                "msas" => read_msas(selected_gene)
                )
        else
            Dict("selected_gene" => selected_gene)
        end
        )
end

function thoraxeresult()
    selected_gene = get(@params, :name, "")
    @show selected_gene
    html(:thoraxeresults, :thoraxeresult, results = THORAXE_RESULTS, selected=selected_gene, data=String(load_gene(selected_gene).body))
end

end
