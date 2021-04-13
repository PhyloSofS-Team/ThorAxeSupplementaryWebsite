function hideAll(){
  jQuery("#spliceGraphPanel").hide();
  jQuery("#rnaseqPanel").hide();
  jQuery("#sExonPanel").hide();
  jQuery("#asesPanel").hide();
  jQuery("#msaPanel").hide();
  jQuery("#geneStructurePanel").hide();
};


function objectLength(obj){
  var size = 0;
  for (key in obj) {
    if (obj.hasOwnProperty(key)){
      size++;
    };
  };
  return size;
};

// tables : start
function createTable(jQSelectorContainer, jQSelectorTable, tableData, tableMeta) {
  var table = jQuery(jQSelectorTable);
  
  var thead_tr = jQuery('<tr>');
  $.each(tableMeta, function(x, col_h) {
    jQuery('<td>').text(col_h).appendTo(thead_tr);
  });
  table.append( jQuery('<thead>').append(thead_tr) );	

  var tbody = jQuery('<tbody>');
  $.each(tableData, function(x, row) {
    if(objectLength(row) > 1){
      var tr = jQuery('<tr>');
      $.each(row, function(y, col) {
          tr.append( jQuery('<td>').text(col) );
      });
      tbody.append(tr);
    };
  });

  table.append(tbody);
  
  jQuery(jQSelectorTable).tablesorter({
    widthFixed : true,
    widgets: ['filter', 'StickyHeaders', 'zebra'],
    widgetOptions: {
      stickyHeaders_attachTo: jQSelectorContainer,
      zebra : [ "normal-row", "alt-row" ],
    }
  });
};
// tables : end

// msa : start
function cleanMSA(){
  jQuery("#msaTitle").empty()
  jQuery("#msa").html('<p class="text-muted">Click on a conserved s-exon of the splice graph to see its MSA.</p>');
};

function renderMSA(msas, sExonId){
  jQuery("#msaTitle").html('<h5>S-exon: ' + sExonId + '</h5>')
  if (sExonId in msas){
    var fasta = msas[sExonId];
    var seqs =  msa.io.fasta.parse(fasta);
    var m = msa({
        el: jQuery("#msa"),
        seqs: seqs,
        vis: {
          seqlogo: true,
          labelId: false,
        },
        zoomer: {
          labelNameLength: 175,
        }
    });
    m.render();
  }else{
    cleanMSA();
  }
};
// msa : end

// gene_structure : start

function isUnique(value, index, self) {
  return self.indexOf(value) === index;
}

// gene_structure : end

jQuery(document).ready(function(){
    jQuery("#loadingImage").hide();

    hideAll();

    geneData = {
      valueInternal: null,
      valueListener: function(val) {},
      set value(val) {
        this.valueInternal = val;
        this.valueListener(val);
      },
      get value() {
        return this.valueInternal;
      },
      registerListener: function(listener) {
        this.valueListener = listener;
      }
    };  // to listen the variable change
  
    /*
    jQuery("#geneSelectorForm").submit(function(e){
      // e.preventDefault(); // avoid to execute the actual submit of the form.
      var selectedGeneName = document.querySelector('#geneName').value;
      jQuery.get(
        "load_gene/" + selectedGeneName,
        function(data){
          geneData.value = data;
        });
    });
    */

    geneData.registerListener(function(val){
      jQuery("#loadingImage").show();

      hideAll();

      jQuery("#geneTitle").html(val.selected_gene);

      setTimeout(function() {
        // tables : start
        jQuery("#sExonTableContainer").empty();
        jQuery("#asesTableContainer").empty();
        // tables : end

        // rnaseq : start
        jQuery("#rnaseqPlots").empty();
        // rnaseq : end
        
        // splice graph : start
        jQuery("#spliceGraphPanel").show();

        var cy = cytoscape({
            container: document.getElementById('cy'),
            elements: val.cytoscape_elements,
            layout: {
                  name: 'klay'
            },
            style: [ // the stylesheet for the graph
                {
                  selector: 'node',
                  style: {
                    'background-color': 'mapData(conservation, 0, 100, yellow, purple)',
                    'content': 'data(label)',
                    'width': 'mapData(conservation, 0, 100, 10, 20)',
                    'height': 'mapData(conservation, 0, 100, 10, 20)',
                  }
                },
                {
                    selector: 'edge',
                    style: {
                      'width': 'mapData(conservation, 0, 1, 2, 6)',
                      'line-color': 'mapData(conservation, 0, 1, yellow, purple)',
                      'mid-target-arrow-shape': 'triangle',
                      'mid-target-arrow-color': 'mapData(conservation, 0, 1, yellow, purple)',
                    }
                  }
            ]
        });
        // splice graph : end

        // msa : start
        cleanMSA();
        jQuery("#msaPanel").show();

        cy.on('click tap touchstart', 'node', function(evt){
          renderMSA(geneData.value.msas, evt.target.data().label);
        });
        // msa : end

        // rnaseq : start
        if(val.rnaseq_plots.length > 0){
          jQuery("#rnaseqPanel").show();
          for (plot in val.rnaseq_plots) {
            plot_path = val.rnaseq_plots[plot];
            ase = plot_path.split("/")[4].replace(".svg", "").replace("barplot_event_", "").replace("can", "Can").replace("alt", "Alt").replace(";", " ").replace(/:/g, ": ").replaceAll(/-/g, "/");
            jQuery("#rnaseqPlots").append('<h5>'+ ase +'</h5><img src="' + plot_path + '">');
          };
        }
        // rnaseq : end

        // tables :start

        // s_exon_table : start
        jQuery("#sExonTableContainer").append('<table class="table" id="sExonTable"></table>');
        Papa.parse(val.s_exon_table, {
          header: true,
          complete: function(results) {
            createTable("#sExonTableContainer", "#sExonTable", results.data, results.meta.fields);
          }
        });
        jQuery("#sExonPanel").show();
        // s_exon_table : end
        
        // ases_table : start
        jQuery("#asesTableContainer").append('<table class="table" id="asesTable"></table>');
        Papa.parse(val.ases_table, {
          header: true,
          complete: function(results) {
            createTable("#asesTableContainer", "#asesTable", results.data, results.meta.fields);
          }
        });
        jQuery("#asesPanel").show();
        // ases_table : end
        
        // needed for the zebra tablesorter widget :
        jQuery('#sExonTable').trigger('applyWidgets'); 
        jQuery('#asesTable').trigger('applyWidgets');

        // tables : end

        // gene_structure : start

        jQuery('#geneStructureContainer').append('<svg id="geneStructure" width=1068 height=500></svg>');

        jQuery("#geneStructurePanel").show();
        
        const geneStructureWidth = parseFloat(d3.select("#geneStructure").attr("width"));

        const geneStructureHeight = parseFloat(d3.select("#geneStructure").attr("height"));

        const geneStructureSVG = d3.select("#geneStructure")
          .call(d3.zoom().on("zoom", function () {geneStructureSVG.attr("transform", d3.event.transform)}))
          .append("g"); // to ensure clip on zooming and panning

        const geneSettings = {
          width: geneStructureWidth,
          height: geneStructureHeight,
          padding: 10,
          margin: { left: 135, right: 100, top: 30, bottom: 30 },
          unselectedOpacity: 0.2,
          fontFamily: "sans-serif",
          fontSize: "10px",
          titleSize: "14px",
          legendSize: 100,
          legendPadding: 20,
          legendShapePadding: 0,
          geneCoordinatesOpacity: 0.5,
          tickPadding: 10,
          boxPadding: -10,
          boxHeight: 20,
        }

        const cleanSExonFooter = function(){
          jQuery("#geneStructureFooter").html("<p>Click on a gene's s-exons to see its data here.</p>")
        };

        const clickSExonSwatch = function(sExon){
          d3.selectAll(".selectedSExon").classed("selectedSExon", false);
          var selectedClass = `.S-exon-${sExon}`;
          var currentOpacity = geneStructureSVG.select(selectedClass + " .swatch").style("opacity");
          var previousSelection = !geneStructureSVG.selectAll(".swatch")
            .filter(function(){
              return +d3.select(this).style("opacity") == geneSettings.unselectedOpacity
            }).empty();
          if ((currentOpacity == "1") && previousSelection){
            cleanSExonFooter();
            geneStructureSVG.selectAll("rect").style("opacity", 1);
            geneStructureSVG.selectAll(".swatch").style("opacity", 1);
          } else {
            geneStructureSVG.selectAll("rect").style("opacity", geneSettings.unselectedOpacity);
            geneStructureSVG.selectAll(".swatch").style("opacity", geneSettings.unselectedOpacity);
            geneStructureSVG.selectAll(selectedClass).style("opacity", 1);
            geneStructureSVG.selectAll(selectedClass + " .swatch").style("opacity", 1);
          }
        };

        const genes = val.s_exon_data.map(d => d.GeneID).filter(isUnique);

        const sExonIDs = val.s_exon_data.map(d => d.S_exonID).filter(isUnique);

        geneNamesAxis = d3.scalePoint()
          .domain(genes)
          .range([geneSettings.margin.top, geneSettings.height - geneSettings.margin.bottom])
          .padding(0.1);

        geneStructureSVG.append("g").call(d3.axisLeft(geneNamesAxis))
          .attr("transform", `translate(${geneSettings.margin.left}, 0)`)
          .call(g => g.select(".domain").remove())
          .style("font-family", geneSettings.fontFamily)
          .style("font-size", geneSettings.fontSize)
          .on("mousedown", function(){
            d3.event.stopPropagation(); // to allow text selection and avoid zooming and panning
          });

        const geneGroups = d3.nest()
          .key(d => d.GeneID)
          .entries(val.s_exon_data);

        const geneCoordinates = geneGroups.map(
          g => 
            ({
              gene: g.key,
              coordinates: (Array.prototype.concat(
                g.values.map(r => r.S_exon_CodingStart),
                g.values.map(r => r.S_exon_CodingEnd))
                .sort())
            })
            // () are needed to create an object, 
            // otherwise js thinks {} defines a function body
          );

          const geneScales = {};
          for (i in geneCoordinates) {
            geneScales[geneCoordinates[i].gene] = d3.scaleLinear()
              .domain(d3.extent(geneCoordinates[i].coordinates))
              .range([geneSettings.margin.left + geneSettings.padding, geneSettings.width - geneSettings.margin.right - geneSettings.padding])
          }
      
          const geneAxis = geneStructureSVG.append("g").attr("id", "genesAxis");
          
          const geneCoordinatesAxis = [];

          geneAxis.selectAll()
            .data(geneCoordinates)
            .enter()
            .append("g")
            .attr("transform", d => `translate(0, ${geneNamesAxis(d.gene)})`)
            .each(
              // arrow function, i.e. => , can not be used with d3.select(this)
              function(d){
                geneCoordinatesAxis.push(d3.select(this).call(
                  d3.axisTop()
                    .scale(geneScales[d.gene])
                    .tickSizeOuter(0)
                    .tickPadding(geneSettings.tickPadding)
                    .tickFormat(d3.format("~s"))
                  ))
                });
            
          geneCoordinatesAxis.map(function(axis){
            axis.style("opacity", geneSettings.geneCoordinatesOpacity)                  
                .style("font-family", geneSettings.fontFamily)
                .style("font-size", geneSettings.fontSize)
                .on("mousedown", function(){
                  d3.event.stopPropagation(); // to allow text selection and avoid zooming and panning
                })
          });


          const sExons = d3.nest()
            .key(d => [d.GeneID, d.S_exonID])
            .entries(val.s_exon_data);
      
          const colorScale = d3.scaleOrdinal().domain(sExonIDs).range(d3.schemeCategory10);

          const showSExonFooter = function(sExonRow){
            footer_text = `<h5>S-exon ${sExonRow.S_exonID} in the gene ${sExonRow.GeneID} (${sExonRow.Species})</h5>`;
            footer_text += '<dl class="row">';
            footer_text += `<dt class="col-sm-2">Strand</dt><dd class="col-sm-10">${sExonRow.Strand}</dd>`;
            footer_text += `<dt class="col-sm-2">Coding start</dt><dd class="col-sm-10">${sExonRow.S_exon_CodingStart}</dd>`;
            footer_text += `<dt class="col-sm-2">Coding end</dt><dd class="col-sm-10">${sExonRow.S_exon_CodingEnd}</dd>`;
            footer_text += `<dt class="col-sm-2">Start phase</dt><dd class="col-sm-10">${sExonRow.S_exon_StartPhase}</dd>`;
            footer_text += `<dt class="col-sm-2">End phase</dt><dd class="col-sm-10">${sExonRow.S_exon_EndPhase}</dd>`;
            footer_text += `<dt class="col-sm-2">Sequence</dt><dd class="col-sm-10">${sExonRow.S_exon_Sequence}</dd>`; 
            footer_text += `<dt class="col-sm-2">Genomic sequence</dt><dd class="col-sm-10">${sExonRow.S_exon_Genomic_Sequence}</dd>`;
            footer_text += "</dl>";
            jQuery("#geneStructureFooter").html(footer_text);
          };

          geneStructureSVG.selectAll("rect")
              .data(sExons)
              .enter()
              .append("rect")
              .attr("y", d => geneNamesAxis(d.values[0].GeneID) + geneSettings.boxPadding)
              .attr("height", geneSettings.boxHeight)
              .attr("x", 
                d => geneScales[d.values[0].GeneID](
                  d3.min([d.values[0].S_exon_CodingStart, d.values[0].S_exon_CodingEnd])
                ))
              .attr("width", d => (
                geneScales[d.values[0].GeneID](d3.max([d.values[0].S_exon_CodingStart, d.values[0].S_exon_CodingEnd])) - 
                geneScales[d.values[0].GeneID](d3.min([d.values[0].S_exon_CodingStart, d.values[0].S_exon_CodingEnd]))
                ))
              .attr("fill", d => colorScale(d.values[0].S_exonID))
              .attr("class", d => `S-exon-${d.values[0].S_exonID}`)
              .on("click", function(d){
                cleanSExonFooter();
                var selected = d3.select(this).classed("selectedSExon");
                d3.selectAll(".selectedSExon").classed("selectedSExon", false);
                geneStructureSVG.selectAll("rect").style("opacity", 1);
                geneStructureSVG.selectAll(".swatch").style("opacity", 1);
                if ( !selected ) {
                  showSExonFooter(d.values[0]);
                  d3.select(this).classed("selectedSExon", true);
                  var selectedClass = `.S-exon-${d.values[0].S_exonID}`;
                  geneStructureSVG.selectAll("rect").style("opacity", geneSettings.unselectedOpacity);
                  geneStructureSVG.selectAll(".swatch").style("opacity", geneSettings.unselectedOpacity);
                  geneStructureSVG.selectAll(selectedClass).style("opacity", 1);
                  geneStructureSVG.selectAll(selectedClass + " .swatch").style("opacity", 1);
                };
              });
      
          const svgLegend = d3.select("#geneStructureLegend");
      
          geneStructureSVG.append("g")
            .attr("id", "sExonLegend")
            .attr("transform", `translate(${geneSettings.width - geneSettings.margin.right + geneSettings.legendPadding}, ${geneSettings.margin.top})`);
          
          const sExonLegend = d3.legendColor()
            .title("S-exons")
            .shape("path", d3.symbol().type(d3.symbolSquare).size(geneSettings.legendSize)())
            .shapePadding(geneSettings.legendShapePadding)
            .scale(colorScale)
            .on("cellclick", clickSExonSwatch);
      
          geneStructureSVG.select("#sExonLegend")
            .call(sExonLegend);
      
          geneStructureSVG.selectAll(".cell")
            .attr("class", d => `S-exon-${d}`)
            .style("font-family", geneSettings.fontFamily)
            .style("font-size", geneSettings.fontSize);
      
          geneStructureSVG.selectAll(".legendTitle")
            .style("font-family", geneSettings.fontFamily)
            .style("font-size", geneSettings.titleSize);

        // gene_structure : end

        jQuery("#loadingImage").hide();
      }, 0);
    });

    // form : start

    window.Parsley.addValidator('datalist', {
      requirementType: 'string',
      validateString: function(value, datalist_id) {
        var datalist_values = Array.from( // convert to Array to use map
          document.getElementById(datalist_id).options // datalist options
          ).map(_ => _.value);
        return datalist_values.includes(value);
      },
      messages: {
        en: 'You should select a gene from the list.'
      }
    });

    $('#geneSelectorForm').parsley({
      errorClass: 'is-invalid text-danger',
      errorsWrapper: '<span class="form-text text-danger"></span>',
      errorTemplate: '<span></span>',
      trigger: 'submit'
    });

    // form : end



  });