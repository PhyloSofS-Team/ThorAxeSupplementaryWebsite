function hideAll(){
  jQuery("#spliceGraphPanel").hide();
  jQuery("#rnaseqPanel").hide();
  jQuery("#sExonPanel").hide();
  jQuery("#asesPanel").hide();
  jQuery("#msaPanel").hide();
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

        jQuery("#loadingImage").hide();
      }, 0);
    });

  });


