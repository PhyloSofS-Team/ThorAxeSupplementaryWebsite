
        graph [
            directed 1
            id 42
            label "splice graph of s-exons"
        
                node [
                    id 1
                    label "start"
                    transcript_fraction 100.0
                    conservation 100.0
                    genes "ENSBTAG00000019958,ENSDARG00000003934,ENSG00000130045,ENSGGOG00000027419,ENSMMUG00000008414,ENSMODG00000013386,ENSMUSG00000021396,ENSRNOG00000014538,ENSSSCG00000035269,ENSXETG00000019220"
                    transcripts "ENSBTAT00000031535/ENSBTAT00000072721,ENSDART00000016103,ENSGGOT00000025486,ENSGGOT00000053860,ENSMMUT00000008032,ENSMMUT00000011764,ENSMODT00000017046,ENSMUST00000021828,ENSRNOT00000019489,ENSSSCT00000050066,ENST00000375855,ENSXETT00000052949"
                ]
            
                node [
                    id 2
                    label "1_0"
                    transcript_fraction 100.0
                    conservation 100.0
                    genes "ENSBTAG00000019958,ENSDARG00000003934,ENSG00000130045,ENSGGOG00000027419,ENSMMUG00000008414,ENSMODG00000013386,ENSMUSG00000021396,ENSRNOG00000014538,ENSSSCG00000035269,ENSXETG00000019220"
                    transcripts "ENSBTAT00000031535/ENSBTAT00000072721,ENSDART00000016103,ENSGGOT00000025486,ENSGGOT00000053860,ENSMMUT00000008032,ENSMMUT00000011764,ENSMODT00000017046,ENSMUST00000021828,ENSRNOT00000019489,ENSSSCT00000050066,ENST00000375855,ENSXETT00000052949"
                    phylosofs "%"
                    consensus "MVDVLGGRXLVTXXGAXVEAEAALQNKVVALYFAAGRCAPSRDFTPLLCDFYTELVXEARXPAPFEVVFVSADGSXXEMLDFMRELHGXWLALPFHDPYRh"
                ]
            
                node [
                    id 3
                    label "3_0"
                    transcript_fraction 75.0
                    conservation 90.0
                    genes "ENSBTAG00000019958,ENSDARG00000003934,ENSGGOG00000027419,ENSMMUG00000008414,ENSMODG00000013386,ENSMUSG00000021396,ENSRNOG00000014538,ENSSSCG00000035269,ENSXETG00000019220"
                    transcripts "ENSBTAT00000031535/ENSBTAT00000072721,ENSDART00000016103,ENSGGOT00000025486,ENSMMUT00000011764,ENSMODT00000017046,ENSMUST00000021828,ENSRNOT00000019489,ENSSSCT00000050066,ENSXETT00000052949"
                    phylosofs "("
                    consensus "HELKKRYXITAIPKLVIVKQNGEVITDKGRKQIRERGLACFQXWVEAADIFQNFSGk"
                ]
            
                node [
                    id 4
                    label "stop"
                    transcript_fraction 100.0
                    conservation 100.0
                    genes "ENSBTAG00000019958,ENSDARG00000003934,ENSG00000130045,ENSGGOG00000027419,ENSMMUG00000008414,ENSMODG00000013386,ENSMUSG00000021396,ENSRNOG00000014538,ENSSSCG00000035269,ENSXETG00000019220"
                    transcripts "ENSBTAT00000031535/ENSBTAT00000072721,ENSDART00000016103,ENSGGOT00000025486,ENSGGOT00000053860,ENSMMUT00000008032,ENSMMUT00000011764,ENSMODT00000017046,ENSMUST00000021828,ENSRNOT00000019489,ENSSSCT00000050066,ENST00000375855,ENSXETT00000052949"
                ]
            
                node [
                    id 5
                    label "4_0"
                    transcript_fraction 16.666666666666664
                    conservation 20.0
                    genes "ENSG00000130045,ENSGGOG00000027419"
                    transcripts "ENSGGOT00000053860,ENST00000375855"
                    phylosofs ")"
                    consensus "QRSLALLPRLECSGVILAHCNLCLLGSSDSLALAS"
                ]
            
                node [
                    id 6
                    label "2_0"
                    transcript_fraction 8.333333333333332
                    conservation 10.0
                    genes "ENSMMUG00000008414"
                    transcripts "ENSMMUT00000008032"
                    phylosofs "+"
                    consensus "HWCRECRKPWKTAAGLGNLSEHKPPNLGHRPSVRGGETAFLMSFRVILVLLLLGPHIVPDSAGQRLVHGPVSVGNQSGVQTLWNLGVLRNL"
                ]
            
                edge [
                    source 1
                    target 2
                    transcript_fraction 100.0
                    conservation 100.0
                    transcript_weighted_conservation 1.0
                    genes "ENSBTAG00000019958,ENSDARG00000003934,ENSG00000130045,ENSGGOG00000027419,ENSMMUG00000008414,ENSMODG00000013386,ENSMUSG00000021396,ENSRNOG00000014538,ENSSSCG00000035269,ENSXETG00000019220"
                    transcripts "ENSBTAT00000031535/ENSBTAT00000072721,ENSDART00000016103,ENSGGOT00000025486,ENSGGOT00000053860,ENSMMUT00000008032,ENSMMUT00000011764,ENSMODT00000017046,ENSMUST00000021828,ENSRNOT00000019489,ENSSSCT00000050066,ENST00000375855,ENSXETT00000052949"
                ]
            
                edge [
                    source 2
                    target 3
                    transcript_fraction 75.0
                    conservation 90.0
                    transcript_weighted_conservation 0.8
                    genes "ENSBTAG00000019958,ENSDARG00000003934,ENSGGOG00000027419,ENSMMUG00000008414,ENSMODG00000013386,ENSMUSG00000021396,ENSRNOG00000014538,ENSSSCG00000035269,ENSXETG00000019220"
                    transcripts "ENSBTAT00000031535/ENSBTAT00000072721,ENSDART00000016103,ENSGGOT00000025486,ENSMMUT00000011764,ENSMODT00000017046,ENSMUST00000021828,ENSRNOT00000019489,ENSSSCT00000050066,ENSXETT00000052949"
                ]
            
                edge [
                    source 3
                    target 4
                    transcript_fraction 75.0
                    conservation 90.0
                    transcript_weighted_conservation 0.8
                    genes "ENSBTAG00000019958,ENSDARG00000003934,ENSGGOG00000027419,ENSMMUG00000008414,ENSMODG00000013386,ENSMUSG00000021396,ENSRNOG00000014538,ENSSSCG00000035269,ENSXETG00000019220"
                    transcripts "ENSBTAT00000031535/ENSBTAT00000072721,ENSDART00000016103,ENSGGOT00000025486,ENSMMUT00000011764,ENSMODT00000017046,ENSMUST00000021828,ENSRNOT00000019489,ENSSSCT00000050066,ENSXETT00000052949"
                ]
            
                edge [
                    source 2
                    target 5
                    transcript_fraction 16.666666666666664
                    conservation 20.0
                    transcript_weighted_conservation 0.15
                    genes "ENSG00000130045,ENSGGOG00000027419"
                    transcripts "ENSGGOT00000053860,ENST00000375855"
                ]
            
                edge [
                    source 5
                    target 4
                    transcript_fraction 16.666666666666664
                    conservation 20.0
                    transcript_weighted_conservation 0.15
                    genes "ENSG00000130045,ENSGGOG00000027419"
                    transcripts "ENSGGOT00000053860,ENST00000375855"
                ]
            
                edge [
                    source 2
                    target 6
                    transcript_fraction 8.333333333333332
                    conservation 10.0
                    transcript_weighted_conservation 0.05
                    genes "ENSMMUG00000008414"
                    transcripts "ENSMMUT00000008032"
                ]
            
                edge [
                    source 6
                    target 4
                    transcript_fraction 8.333333333333332
                    conservation 10.0
                    transcript_weighted_conservation 0.05
                    genes "ENSMMUG00000008414"
                    transcripts "ENSMMUT00000008032"
                ]
            
        ]
        