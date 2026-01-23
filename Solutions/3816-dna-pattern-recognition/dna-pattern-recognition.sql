-- This query selects sample information and identifies specific patterns in the DNA sequence.
-- It adds flags for the presence of start codon (ATG), stop codons (TAA, TAG, TGA),
-- and specific motifs (ATAT, GGG) in each DNA sequence.
select 
    sample_id,
    dna_sequence,
    species,
    case when dna_sequence like 'ATG%' then 1 else 0 end as has_start,
    case 
        when dna_sequence like '%TAA' then 1
        when dna_sequence like '%TAG' then 1
        when dna_sequence like '%TGA' then 1
        else 0
    end as has_stop,
    case when dna_sequence like '%ATAT%' then 1 else 0 end as has_atat,
    case when dna_sequence like '%GGG%' then 1 else 0 end as has_ggg
from Samples
order by sample_id;
