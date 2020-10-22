
        graph [
            directed 1
            id 42
            label "splice graph of s-exons"
        
                node [
                    id 1
                    label "start"
                    transcript_fraction 100.0
                    conservation 100.0
                    genes "ENSBTAG00000016773,ENSDARG00000052035,ENSG00000171773,ENSGGOG00000002347,ENSMODG00000004441,ENSMUSG00000034829,ENSRNOG00000042658,ENSSSCG00000040328,ENSXETG00000000210"
                    transcripts "ENSBTAT00000022306,ENSDART00000143829,ENSGGOT00000002359,ENSMODT00000005590,ENSMODT00000053125,ENSMODT00000079810,ENSMUST00000048243/ENSMUST00000163659,ENSRNOT00000024434,ENSRNOT00000080706,ENSSSCT00000065552,ENST00000301944,ENSXETT00000004660"
                ]
            
                node [
                    id 2
                    label "1_1"
                    transcript_fraction 100.0
                    conservation 100.0
                    genes "ENSBTAG00000016773,ENSDARG00000052035,ENSG00000171773,ENSGGOG00000002347,ENSMODG00000004441,ENSMUSG00000034829,ENSRNOG00000042658,ENSSSCG00000040328,ENSXETG00000000210"
                    transcripts "ENSBTAT00000022306,ENSDART00000143829,ENSGGOT00000002359,ENSMODT00000005590,ENSMODT00000053125,ENSMODT00000079810,ENSMUST00000048243/ENSMUST00000163659,ENSRNOT00000024434,ENSRNOT00000080706,ENSSSCT00000065552,ENST00000301944,ENSXETT00000004660"
                    phylosofs "%"
                    consensus "MASLFSGRILIRNNSDQDELDTEAELSRRLENRLVLLFFGAGXCPQCQAFAPILKDFFVRLTDEFYVLRAAQLALVYVSQDXTEEQQDLFLRDMPKKWLFLPFEDeDLRR"
                ]
            
                node [
                    id 3
                    label "2_0"
                    transcript_fraction 91.66666666666666
                    conservation 100.0
                    genes "ENSBTAG00000016773,ENSDARG00000052035,ENSG00000171773,ENSGGOG00000002347,ENSMODG00000004441,ENSMUSG00000034829,ENSRNOG00000042658,ENSSSCG00000040328,ENSXETG00000000210"
                    transcripts "ENSBTAT00000022306,ENSDART00000143829,ENSGGOT00000002359,ENSMODT00000005590,ENSMODT00000053125,ENSMODT00000079810,ENSMUST00000048243/ENSMUST00000163659,ENSRNOT00000024434,ENSSSCT00000065552,ENST00000301944,ENSXETT00000004660"
                    phylosofs "("
                    consensus "rDLGRQFSVXXLPAVVVLKPXGDVLTXDAXDEIQRLGPACFANWQEAAEVLDRSFLQPEDLDDPAPRSLTEPLRRXKYRVXXXAXRkkGRXRXGxDXXXXGGXXgxxaELFg"
                ]
            
                node [
                    id 4
                    label "stop"
                    transcript_fraction 100.0
                    conservation 100.0
                    genes "ENSBTAG00000016773,ENSDARG00000052035,ENSG00000171773,ENSGGOG00000002347,ENSMODG00000004441,ENSMUSG00000034829,ENSRNOG00000042658,ENSSSCG00000040328,ENSXETG00000000210"
                    transcripts "ENSBTAT00000022306,ENSDART00000143829,ENSGGOT00000002359,ENSMODT00000005590,ENSMODT00000053125,ENSMODT00000079810,ENSMUST00000048243/ENSMUST00000163659,ENSRNOT00000024434,ENSRNOT00000080706,ENSSSCT00000065552,ENST00000301944,ENSXETT00000004660"
                ]
            
                node [
                    id 5
                    label "3_0"
                    transcript_fraction 8.333333333333332
                    conservation 11.11111111111111
                    genes "ENSGGOG00000002347"
                    transcripts "ENSGGOT00000002359"
                    phylosofs ")"
                    consensus "QGPDKKKKKKKKKEEEMRRRRKGGGGEGRGGGGGQEETRIGEDVQKIIFKNLRHCWWKWKMVQLLWKSLRVPQRVKIK"
                ]
            
                node [
                    id 6
                    label "5_0"
                    transcript_fraction 16.666666666666664
                    conservation 11.11111111111111
                    genes "ENSMODG00000004441"
                    transcripts "ENSMODT00000005590,ENSMODT00000079810"
                    phylosofs "+"
                    consensus "NISIIELGHTINWTDDLMVSHNS"
                ]
            
                node [
                    id 7
                    label "4_0"
                    transcript_fraction 16.666666666666664
                    conservation 11.11111111111111
                    genes "ENSMODG00000004441"
                    transcripts "ENSMODT00000053125,ENSMODT00000079810"
                    phylosofs "0"
                    consensus "MVTLTLFTTSPSSVLLIVSQKAGFSALSEK"
                ]
            
                node [
                    id 8
                    label "1_0"
                    transcript_fraction 16.666666666666664
                    conservation 11.11111111111111
                    genes "ENSMODG00000004441"
                    transcripts "ENSMODT00000053125,ENSMODT00000079810"
                    phylosofs "1"
                    consensus "ACLRTGLWEPGRTG"
                ]
            
                node [
                    id 9
                    label "6_0"
                    transcript_fraction 8.333333333333332
                    conservation 11.11111111111111
                    genes "ENSMODG00000004441"
                    transcripts "ENSMODT00000053125"
                    phylosofs "2"
                    consensus "QNASFSDF"
                ]
            
                node [
                    id 10
                    label "0_1"
                    transcript_fraction 8.333333333333332
                    conservation 11.11111111111111
                    genes "ENSRNOG00000042658"
                    transcripts "ENSRNOT00000080706"
                    phylosofs "3"
                ]
            
                edge [
                    source 1
                    target 2
                    transcript_fraction 83.33333333333334
                    conservation 100.0
                    transcript_weighted_conservation 0.9259259259259258
                    genes "ENSBTAG00000016773,ENSDARG00000052035,ENSG00000171773,ENSGGOG00000002347,ENSMODG00000004441,ENSMUSG00000034829,ENSRNOG00000042658,ENSSSCG00000040328,ENSXETG00000000210"
                    transcripts "ENSBTAT00000022306,ENSDART00000143829,ENSGGOT00000002359,ENSMODT00000005590,ENSMUST00000048243/ENSMUST00000163659,ENSRNOT00000024434,ENSRNOT00000080706,ENSSSCT00000065552,ENST00000301944,ENSXETT00000004660"
                ]
            
                edge [
                    source 2
                    target 3
                    transcript_fraction 91.66666666666666
                    conservation 100.0
                    transcript_weighted_conservation 0.9444444444444444
                    genes "ENSBTAG00000016773,ENSDARG00000052035,ENSG00000171773,ENSGGOG00000002347,ENSMODG00000004441,ENSMUSG00000034829,ENSRNOG00000042658,ENSSSCG00000040328,ENSXETG00000000210"
                    transcripts "ENSBTAT00000022306,ENSDART00000143829,ENSGGOT00000002359,ENSMODT00000005590,ENSMODT00000053125,ENSMODT00000079810,ENSMUST00000048243/ENSMUST00000163659,ENSRNOT00000024434,ENSSSCT00000065552,ENST00000301944,ENSXETT00000004660"
                ]
            
                edge [
                    source 3
                    target 4
                    transcript_fraction 58.333333333333336
                    conservation 77.77777777777779
                    transcript_weighted_conservation 0.7222222222222222
                    genes "ENSBTAG00000016773,ENSDARG00000052035,ENSG00000171773,ENSMUSG00000034829,ENSRNOG00000042658,ENSSSCG00000040328,ENSXETG00000000210"
                    transcripts "ENSBTAT00000022306,ENSDART00000143829,ENSMUST00000048243/ENSMUST00000163659,ENSRNOT00000024434,ENSSSCT00000065552,ENST00000301944,ENSXETT00000004660"
                ]
            
                edge [
                    source 3
                    target 5
                    transcript_fraction 8.333333333333332
                    conservation 11.11111111111111
                    transcript_weighted_conservation 0.1111111111111111
                    genes "ENSGGOG00000002347"
                    transcripts "ENSGGOT00000002359"
                ]
            
                edge [
                    source 5
                    target 4
                    transcript_fraction 8.333333333333332
                    conservation 11.11111111111111
                    transcript_weighted_conservation 0.1111111111111111
                    genes "ENSGGOG00000002347"
                    transcripts "ENSGGOT00000002359"
                ]
            
                edge [
                    source 3
                    target 6
                    transcript_fraction 16.666666666666664
                    conservation 11.11111111111111
                    transcript_weighted_conservation 0.07407407407407407
                    genes "ENSMODG00000004441"
                    transcripts "ENSMODT00000005590,ENSMODT00000079810"
                ]
            
                edge [
                    source 6
                    target 4
                    transcript_fraction 16.666666666666664
                    conservation 11.11111111111111
                    transcript_weighted_conservation 0.07407407407407407
                    genes "ENSMODG00000004441"
                    transcripts "ENSMODT00000005590,ENSMODT00000079810"
                ]
            
                edge [
                    source 1
                    target 7
                    transcript_fraction 16.666666666666664
                    conservation 11.11111111111111
                    transcript_weighted_conservation 0.07407407407407407
                    genes "ENSMODG00000004441"
                    transcripts "ENSMODT00000053125,ENSMODT00000079810"
                ]
            
                edge [
                    source 7
                    target 8
                    transcript_fraction 16.666666666666664
                    conservation 11.11111111111111
                    transcript_weighted_conservation 0.07407407407407407
                    genes "ENSMODG00000004441"
                    transcripts "ENSMODT00000053125,ENSMODT00000079810"
                ]
            
                edge [
                    source 8
                    target 2
                    transcript_fraction 16.666666666666664
                    conservation 11.11111111111111
                    transcript_weighted_conservation 0.07407407407407407
                    genes "ENSMODG00000004441"
                    transcripts "ENSMODT00000053125,ENSMODT00000079810"
                ]
            
                edge [
                    source 3
                    target 9
                    transcript_fraction 8.333333333333332
                    conservation 11.11111111111111
                    transcript_weighted_conservation 0.037037037037037035
                    genes "ENSMODG00000004441"
                    transcripts "ENSMODT00000053125"
                ]
            
                edge [
                    source 9
                    target 4
                    transcript_fraction 8.333333333333332
                    conservation 11.11111111111111
                    transcript_weighted_conservation 0.037037037037037035
                    genes "ENSMODG00000004441"
                    transcripts "ENSMODT00000053125"
                ]
            
                edge [
                    source 2
                    target 10
                    transcript_fraction 8.333333333333332
                    conservation 11.11111111111111
                    transcript_weighted_conservation 0.05555555555555555
                    genes "ENSRNOG00000042658"
                    transcripts "ENSRNOT00000080706"
                ]
            
                edge [
                    source 10
                    target 4
                    transcript_fraction 8.333333333333332
                    conservation 11.11111111111111
                    transcript_weighted_conservation 0.05555555555555555
                    genes "ENSRNOG00000042658"
                    transcripts "ENSRNOT00000080706"
                ]
            
        ]
        