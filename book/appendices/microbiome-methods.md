# Appendix: A brief introduction to methods in microbiome science

There isn’t a clear definition for the term microbe. It has been defined based
on human perception, such as an organism so small that it can’t be seen with the
naked eye. A similar size-based definition is any organism smaller than 200
micrometers (μm). And a third definition is any single-celled organism. These
definitions are similar enough that for most purposes it doesn’t matter which we
choose, but the size-based definition is the least ambiguous, so we’ll adopt
that for the purposes of this book. This is preferable to a definition based on
human perception because it’s more objective. It’s also preferable to a
definition based on the number of cells that compose the organism because there
are some interesting creatures that sometimes exist in a single-cellular state,
and at other times in a multicellular state, like slime molds which band
together when times get tough.

200 μm is about 5 times smaller than the period at the end of this sentence, and
as far as microbes go, 200 μm is massive! The largest known bacteria include
_Thiomargarita namibiensis_ (100-750 μm), and species in the genus
_Epulopiscium_ (200-700 μm) which were so large that when they were first
discovered the researchers didn’t even think they were bacteria. One the other
end of the spectrum, the smallest known bacteria are in the genus _Mycoplasma_,
and they are on the order of 200 nanometers (nm) in diameter, about 5000 times
smaller than the period at the end of this sentence. The ratio of the size of
the smallest to largest bacterium is about the same as the ratio of the size of
an ant to a blue whale.

In this chapter, I'll provide some historical context on methods used in
microbiome science. The history of the field is rich, and the contributors so
many, that I could easily divert all of my focus to trying to tell that story
and as a result not help you learn QIIME 2. I therefore keep it brief here, and
provide references through-out to resources that can help you fill in my gaps.

## The pre-history of microbiome research

Until relatively recently we barely knew microbes existed. Antonie van Leuenhook
(1632-1723), a dutch microscope hobbyist in late 1600s, was the first to observe
and describe microbes (in terms including _animacules_ and _wee beasties_).
Using microscopes that he expertly crafted and which achieved maginfication of
about 200x, he explored microbial diversity in nearly everything he could get
his hands on, from rain water to dental plaque, and reported his findings to the
Royal Society. Van Leuenhook is credited with discovering microbes (and through
his exploration of microbes in and on the human body, he discovered  the healthy
human microbiome), though he was very private about the methods he used to
develop his microscopes {cite}`Lane2015-sa`. When van Leuenhook died in 1723 the
microbial world faded from view with him for nearly 200 years. In fact many of
his findings were called into question as they could not be reproduced with
other (less powerful) microscopes, but his reports were confirmed when compound
microscopes were developed. Among those who did believe van Leuenhook’s
findings, the consensus was that microbes were small, usual organisms of no
relevance to our lives. This is because, with few exceptions, microbes are
harmless. Many more microbes are beneficial to us, but the benefits they provide
are realized regardless of whether we believe in them or not (as long as we let
them be, that is).

It wasn’t for another couple of hundred years that microbes were recognized to
have any relevance to our lives, and even then it was a controversial idea.
These next views of microbes were negative ones, when disease brought microbes
to our attention. In 1854 London, a young medical doctor named John Snow
(1813-1858) had a hypothesis that the cholera epidemic spreading through London
at the time moved through drinking water that had been contaminated with human
waste. This stood in contrast to the belief held by most at the time: that
cholera spread through “bad air”. In the first example of a modern public health
study, Dr. Snow traced the contaminated water to a single pump in London, the
Broad Street pump, by determining that most of the individuals who developed
cholera obtained their drinking water from that pump. He convinced city
officials to disable the Broad Street pump by removing its handle, and cholera
deaths immediately began to decline. Despite this impactful result, Snow did not
know what caused the illness, beyond some contaminant in the water. A full
understanding of the cause of cholera did not prevent measures from being put in
place that began improving human health and quality of life, such as sanitation
improvements. And even with a detailed molecular understanding of cholera
transmission and pathogenesis today, it still kills tens of thousands of people
per year.

In the 1880s, Robert Koch (1843-1910), a German physician, in collaboration with
Walther (1846-1911) and Fanny Hesse (1850-1934), developed techniques for
growing bacteria in culture using agar, a Jell-o like substance minus the food
coloring, as a growth medium. Because microbes are so small, it helps (even
today) to be able to increase the quantity of the unit of study, whether that be
microbial cells or microbial DNA. By growing organisms that he isolated from
sick humans, Koch for the first time identified bacteria as the cause of several
human diseases, including anthrax, tuberculosis, and cholera. He therefore added
several new pieces to the puzzle which Snow began, as cholera could now be
linked to the bacterium _Vibrio cholera_. One of Koch’s most lasting legacies is
his four postulates for identifying causality for a microorganism in disease.
Koch’s postulates are:
 1. The organism must always be present, in every case of the disease.
 2. The organism must be isolated from a host containing the disease and grown
    in pure culture.
 3. Samples of the organism taken from pure culture must cause the same disease
    when inoculated into a healthy, susceptible animal in the laboratory.
 4. The organism must be isolated from the inoculated animal and must be
    identified as the same original organism first isolated from the originally
    diseased host.

The dominant views of microbes, from Koch’s time through today in many circles,
has been that they were human pathogens and agricultural pests. Some of them
are, but our efforts to make war on microbes have likely decreased agricultural
productivity, and created new health problems for ourselves and the animals we
care for (such as our pets and our livestock). During the last century, our
attitude toward microbes has been shifting as we increasingly recognize that
they are important to our good health, not only our bad health.

An excellent book covering the early history of microbial research is _Microbe
Hunters_ {cite}`De_Kruif2002-zg`, orignally published in 1926. I found it to be
an accessible and engaging introduction to the field, but I also found some
language to be racially and socially insensitive. The state of microbiology, and
the language used to describe it, are reflective of the time when the book was
written.

## Microbial diversity

Microbial diversity, the different types of microbes that exist, dwarfs the
diversity of non-microbes. However, because of the difficulty of observing and
characterizing microbes, until very recently that diversity went largely
unrecognized.

Taxonomists are biologists who focus on classification and naming of organisms.
Historically, taxonomists used directly observable traits of organisms to
categorize them. For example, monotremes are a subgroup of the taxonomic group
mammals who have all of the features that define mammals, such as the presence
of hair or fur, but are unique from other mammals in that they lay eggs.
(Echidna and platypus are the only extant monotremes.) Since microbes and the
features that differentiate them are invisible to the naked eye, this posed a
problem for taxonomists. In fact, Carl Linneaus, “the father of taxonomy”,
lumped all of van Leeuwenhoek’s animalcules together. Until the last few
decades, microbes were thought to be comprised of a few thousand species: an
unusual group of organisms in the tree of life, far less diverse than insects
which were previously thought to be the most diverse taxonomic grouping. But
scientists began noticing things that suggested there might be more to these
creatures than we previously thought. For example, when looking at a sample of
live microbes under a microscope many different shapes and sizes of organisms
could be seen moving around. But when culturing from that same sample, many
fewer types were observed. This indicated that the most common approach for
studying microbes, growing them in the lab, might be selectively growing only a
subset of microbes that were capable of growing under the lab conditions. To
relate this idea back to the world that we can see, imagine trying to
characterize plant diversity by growing all of the possible plants in your
backyard. Depending on where you live, you might observe Saguaro cactus or you
might observe banana trees, but you won’t observe both. Your local climate will
select for the plants that you will be capable of observing. In fact, this
selection process led early gut microbiome researchers to believe that
Escherichia coli (or E. coli) was an abundant organism in the healthy human gut.
When researchers would grow microbes from human stool, they found their cultures
to be dominated by E. coli. Using more modern approaches we now know that E.
coli make up only around 0.01% of the bacterial cells in a healthy human gut. It
just happens to grow well in the lab.

Other experiments that were run around the same time suggested that microbes
might be more important to our lives than previously thought. For example,
researchers interested in the role of microbes in agriculture grew test crops in
soil that had been sterilized and compared that to crops grown in typical soil.
These experiments have been replicated many times, and consistently show that
crop yield is higher in soil that has not been sterilized relative to soil that
has been sterilized. This suggested that microbes may be important for crop
growth, and ran counter to the belief at the time that microbes found in
agricultural systems were either unimportant or were pests that had a negative
impact on plants. Our growing understanding of the importance of microbes in
soil health is at the heart of the regenerative agriculture movement, and
parallels our increasing appreciation of the importance of microbes that live in
and on our bodies for our health.

The field of taxonomy predated Darwin’s theory of evolution, and thus wasn’t
initially intended to describe evolutionary relationships. In some cases
however, early taxonomic classifications do mirror evolutionary history as we
understand it. For example, the monotremes (mentioned earlier) are an early twig
on the mammalian branch in the tree of life. The last common ancestor of the
extant monotremes was also a monotreme, and the last common ancestor of all
mammals is thought to have been an egg laying mammal. This connects mammals to
our reptilian ancestor. In this case, the observable features of these animals
seems to have led us to an accurate view of their evolutionary relationships.
This isn’t always the case though: observable features can lead us astray.

Powered flight, for example, is thought to have evolved independently four
times: in insects, in mammals (bats), in dinosaurs, and in birds (birds evolved
from dinosaurs, but not from flying dinosaurs). In this case, the observable
feature of powered flight wouldn’t lead us to an accurate view of evolutionary
history. The last common ancestor of bats, insects, dinosaurs, and birds didn’t
fly. This was an ability that distinct evolutionary lineages converged on as a
result of the obvious benefits it provides, such as the ability to escape
predators that can’t fly. Because the features of microbes are so hard to see,
taxonomic classifications of microbes frequently don’t represent evolutionary
history, and as a result microbial taxonomy is messy. As of this writing,
microbial taxonomy is under constant revision which leads to a lot of confusion
and controversy.

## The genome as a tool for understanding evolution

Recently a new organismal feature has become observable, and it has
revolutionized our understanding of evolutionary history. This feature is the
genome sequence of an organism. The genome is the primary store of biological
information in an organism, or the full collection of its DNA. An organism’s
genome encodes blueprints for its molecular machines, proteins and some RNA
molecules, and when put in precisely the right context (which we are only
beginning to understand), it serves as a program for creating that organism. The
building blocks of DNA are four molecules called nucleotides: adenine, cytosine,
guanine, and thymine. These are generally abbreviated as A, C, G, and T,
respectively. DNA is a linear molecule, where nucleotides are covalently linked
to one another, and a DNA sequence therefore refers to the linear order of As,
Cs, Gs, and Ts in some DNA molecule. For example, a short DNA sequence might
look like the following:

``` lang-none
ACCGAGATTCAGATCAGGATAGCAAGAC
```

DNA sequences have directionality, a defined beginning and end that is related
to the chemical structure of nucleotides. For our purposes, we’ll always read a
DNA sequence from left to right, in the same way that we would read a sentence
written in English.

The infamous “double helix” describes the structure in which DNA is most often
found: two linear strands of DNA containing mutual information, meaning that if
you know the sequence of one strand, you also know the sequence of the other
strand. The double helix serves essential roles in reproduction and genome
stability, but since the information is duplicated across the two strands, when
we represent DNA sequences in text or on computers we only reference one strand
as I did above.

For the purpose of illustration, this is what that DNA sequence would look like
with its complementary strand (or the opposite stand in the double helix).

``` lang-none
5’ - ACCGAGATTCAGATCAGGATAGCAAGAC - 3’
3’ - GTCTTGCTATCCTGATCTGAATCTCGGT - 5’
```

The 5’ and 3’ (read as “five prime” and “three prime”, respectively) refer to
features of the nucleotide molecular structure, and define the directionality of
the DNA sequence. By convention, we always read DNA sequences from their 5’ to
3’ end, which is the same way they’re processed in nearly all biological
scenarios. Notice that As are always paired with Ts, and Gs are always paired
with Cs. Also notice that the two molecules are in opposite orientations: these
sequences are said to be reverse complements of one another.

The technology that has been most responsible for our recent advances in
understanding the microbial world has been cost-effective DNA sequencing. DNA
sequencing is sometimes applied to determine the sequence of the complete genome
sequence of an organism. For example, the Human Genome Project’s primary goal
was to determine the linear order of As, Cs, Gs, and Ts in the human genome, and
this was completed in 2001. DNA sequencing is also applied to sequence fragments
of one or more genomes as well. A single gene may be sequenced from the human
genome to determine which variant of a gene an individual has. A single
chromosome may be sequenced to determine heredity. For example, the National
Geographic Genographic Project was an early large-scale application of this
approach to elucidate historical patterns of human migration. In this
crowd-funded project, Y chromosomes were sequenced to determine paternal lineage
in males (females don’t have Y chromosomes, so the sequence of a male’s Y
chromosome is very informative for tracing paternal lineage) and mitochondrial
genomes were sequenced to determine maternal lineage (since mitochondrial
genomes are inherited only from an individual’s mother).

Whole and partial genome sequencing are both applied to study microbes. Whole
genome sequencing is generally ideal for the extensive information it provides
on the functional potential and evolutionary history of the organism -
information that we are only beginning to understand how to decode. There are
technical hurdles associated with whole genome sequencing of microbes that
increase the cost relative to partial genome sequencing, but as I write this
there are tens of thousands of microbiologists, molecular biologists, chemists,
physicists, bioinformaticians, and statisticians improving our approaches for
isolating microbial organisms, sequencing their genomes with less input DNA
(obviating the need for growing a microbe in monoculture to obtain enough DNA to
sequence its genome), and processing and interpreting the results, thereby
reducing the cost of whole genome sequencing.

Partial genome sequencing refers to sequencing only portions of an organism’s
genome, and can be carried out in many ways. The approach of isolating certain
genes from the genome for sequencing is popular in multiple areas of research,
and has formed the basis for our current approaches to building phylogenetic
trees, which represent models or hypotheses about the evolutionary relationships
between organisms. An example is useful to illustrate this. Below are DNA
sequences of cytochrome c oxidase I (COI), a gene that is found in all animals
and which is essential to the production of ATP in the mitochondria. Because all
animals encode this gene in their mitochondria, it is frequently used as a
"barcode of animal life". The sequences below are from four different species:
humans, squirrel monkey, echidna, and platypus. Scan through these and notice
that there are some bases that are the same across all four species (e.g., the
first three bases, `ATG`), and some that differ (the second three bases are
`TTC` in human, echidna, and platypus, but at `TTT` in squirrel monkey). These
sequences were obtained from the CO-ARBitrator COI reference database
{cite}`Heller2017-rt`, and presented here in FASTA format.

``` lang-none
>AY195746 Homo sapiens (human)
ATGTTCGCCGACCGTTGACTATTCTCTACAAACCACAAAGACATTGGAACACTATACCTATTATTCGGCGCATGAGCTGGAGTCCTAGGCACAGCTCTAAGCCTCCTTATTCGAGCCGAGCTGGGCCAGCCAGGCAACCTTCTAGGTAACGACCACATCTACAACGTTATCGTCACAGCCCATGCATTTGTAATAATCTTCTTCATAGTAATACCCATCATAATCGGAGGCTTTGGCAACTGACTAGTTCCCCTAATAATCGGTGCCCCCGATATGGCGTTTCCCCGCATAAACAACATAAGCTTCTGACTCTTACCTCCCTCTCTCCTACTCCTGCTCGCATCTGCTATAGTGGAGGCCGGAGCAGGAACAGGTTGAACAGTCTACCCTCCCTTAGCAGGGAACTACTCCCACCCTGGAGCCTCCGTAGACCTAACCATCTTCTCCTTACACCTAGCAGGTGTCTCCTCTATCTTAGGGGCCATCAATTTCATCACAACAATTATCAATATAAAACCCCCTGCCATAACCCAATACCAAACGCCCCTCTTCGTCTGATCCGTCCTAATCACAGCAGTCCTACTTCTCCTATCTCTCCCAGTCCTAGCTGCTGGCATCACTATACTACTAACAGACCGCAACCTCAACACCACCTTCTTCGACCCCGCCGGAGGAGGAGACCCCATTCTATACCAACACCTATTCTGATTTTTCGGTCACCCTGAAGTTTATATTCTTATCCTACCAGGCTTCGGAATAATCTCCCATATTGTAACTTACTACTCCGGAAAAAAAGAACCATTTGGATACATAGGTATGGTCTGAGCTATGATATCAATTGGCTTCCTAGGGTTTATCGTGTGAGCACACCACATATTTACAGTAGGAATAGACGTAGACACACGAGCATATTTCACCTCCGCTACCATAATCATCGCTATCCCCACCGGCGTCAAAGTATTTAGCTGACTCGCCACACTCCACGGAAGCAATATGAAATGATCTGCTGCAGTGCTCTGAGCCCTAGGATTCATCTTTCTTTTCACCGTAGGTGGCCTGACTGGCATTGTATTAGCAAACTCATCACTAGACATCGTACTACACGACACGTACTACGTTGTAGCCCACTTCCACTATGTCCTATCAATAGGAGCTGTATTTGCCATCATAGGAGGCTTCATTCACTGATTTCCCCTATTCTCAGGCTACACCCTAGACCAAACCTACGCCAAAATCCATTTCACTATCATATTCATCGGCGTAAATCTAACTTTCTTCCCACAACACTTCTTCGGCCTATCCGGAATGCCCCGACGTTACTCGGACTACCCCGATGCATACACCACATGAAACATCCTATCATCTGTAGGCTCATTCATTTCTCTAACAGCAGTAATATTAATAATTTTCATGATTTGAGAAGCCTTCGCTTCGAAGCGAAAAGTCCTAATAGTAGAAGAACCCTCCATAAACCTGGAGTGACTATATGGATGCCCCCCACCCTACCACACATTCGAAGAACCCGTATACATAAAATCTAGA

>FJ785425 Saimiri sciureus (squirrel monkey)
ATGTTTATAAGCCGCTGACTATTCTCAACTAATCACAAAGACATTGGAACGTTATATTTATTATTTGGTGCATGAGCTGGGGCAGTAGGGACTGCCTTGAGCCTCCTGATTCGTGCAGAGCTGGGTCAACCAGGGAGTCTCATAGAAGATGATCACATTTTCAACGTTATTGTCACCGCCCATGCATTCATTATAATTTTCTTCATAGTAATACCCATCATAATTGGAGGTTTTGGAAACTGACTCATCCCGCTAATAATTGGTGCCCCCGACATAGCATTTCCTCGAATAAATAACATAAGTTTCTGACTCTTACCCCCATCACTCCTTCTCTTACTTGCATCCTCAACTCTAGAAGCTGGCGCAGGGACTGGGTGAACTGTTTATCCTCCTCTAGCAGGAAATATATCACACCCAGGGCCCTCCGTGGATCTCACTATCTTTTCACTCCACCTGGCCGGTATTTCCTCTATTCTAGGGGCAATTAATTTTATTACAACAATTATTAATATAAAACCACCAGCGATGAGTCAATATCAGACACCCCTATTTGTCTGATCTGTGTTCATTACAGCAGTCCTCCTACTCCTCTCACTCCCAGTCCTAGCTGCCGGAATTACAATACTCCTAACTGATCGCAATCTTAACACCTCCTTCTTCGACCCAGCTGGGGGAGGCGACCCTATTCTTTACCAACATTTATTCTGATTTTTTGGACACCCTGAAGTATACATCCTCATCCTTCCTGGCTTTGGCATGATCTCCCACATTGTTACATACTACTCCAACAAAAAAGAACCATTCGGATATATAGGGATGGTATGAGCTATAATATCTATCGGCTTTTTAGGCTTCATCGTATGGGCTCACCACATATTCACAGTAGGAATAGATGTGGACACCCGAGCATATTTCACATCAGCCACTATAATCATCGCCATTCCCACCGGAGTAAAAGTATTTAGCTGACTAGCTACACTGCACGGAGGAAATATCAAATGATCCGCCGCTATACTATGAGCTCTCGGATTTATCTTTCTCTTCACTGTAGGCGGGCTAACAGGAATCGTCTTAGCTAACTCATCATTAGATATCGTCTTACATGATACGTACTATGTGGTAGCTCACTTCCACTACGTCCTATCAATGGGAGCAGTATTTGCTATTATGGGGGGCTTTATTCACTGGTTCCCATTATTCTCGGGCTACACACTTGACCAAACCTATGCTAAAACTCATTTTACCATTATATTCGTAGGCGTTAACATAACTTTCTTCCCACAACACTTTCTCGGTCTATCAGGAATGCCCCGACGATACTCAGACTATCCCGATGCATACACTACATGAAACATTATCTCATCTGTGGGCTCATTCATCTCATTAGTAGCAGTAATTCTAATAATTTTTATAATTTGAGAAGCCTTCTCCTCAAAGCGAAAAGTTCTAGTTATTGAACAAACATCTACCAATCTAGAATGACTCTACGGCTGCCCTCCCCCTTACCACACATTTGAGGAGTCTACCTATGTAAAACTTTAG

>NC_003321 Tachyglossus aculeatus (short-beaked echidna)
ATGTTCATTAATCGCTGACTATTTTCAACTAACCATAAAGATATTGGTACCCTCTATCTTCTATTCGGTGCATGAGCTGGCATAGCCGGCACAGCCCTCAGTATTCTCATTCGATCCGAATTAGGCCAACCAGGCTCCCTCTTAGGTGATGATCAAATTTATAACGTTATCGTCACAGCCCATGCATTTGTTATGATTTTTTTCATAGTTATGCCAATCATAATCGGAGGTTTTGGTAACTGATTGGTCCCCCTAATGATTGGGGCTCCAGATATAGCATTCCCACGAATAAACAATATGAGTTTCTGGCTTTTACCCCCTTCATTTCTCCTACTCCTAGTTTCCTCCACAGTAGAAGCAGGCGCAGGAACTGGCTGAACCGTCTATCCACCCCTAGCAGGCAACCTAGCCCATGCTGGAGCCTCAGTAGACCTGGCTATTTTTTCCCTTCACCTAGCTGGAGTTTCCTCTATCCTAGGGGCTATTAACTTTATTACCACAATCATTAACATGAAACCTCCTGCAATATCCCAATATCAAACACCCCTGTTCGTCTGATCAGTACTAGTTACAGCTGTCCTTCTCCTTTTATCACTCCCCGTCCTTGCGGCAGGCATTACCATACTTCTCACTGACCGAAATCTTAATACAACTTTCTTTGACCCAGCAGGGGGTGGAGATCCTATTTTATATCAACACCTGTTCTGATTTTTTGGACACCCTGAAGTCTATATCTTAATCTTACCAGGCTTTGGAATTATCTCTCATATTGTTACTTACTACTCAGGAAAAAAAGAACCATTCGGGTATATAGGAATAGTTTGAGCTATGATATCCATCGGATTTTTAGGTTTCATCGTATGGGCTCACCACATATTTACAGTTGGCATAGACGTAGATACGCGAGCCTACTTCACATCCGCTACAATAATTATTGCTATTCCCACTGGCGTTAAAGTTTTTAGCTGGCTTGCCACACTTCACGGTGGTGATATCAAGTGAACTCCCCCTATACTATGAGCTCTCGGCTTTATTTTCCTTTTTACCGTAGGAGGCCTAACGGGTATTGTTTTAGCAAACTCATCATTAGATATTATTCTTCACGATACATACTACGTAGTAGCCCACTTTCATTACGTCTTATCCATGGGAGCTGTATTTGCTATCATAGGAGGCTTTGTCCACTGATTCCCTCTTCTATCAGGCTTTACACTCCATACAACATGGGCCAAAGTCCACTTTACCCTGATATTTGTCGGAGTTAATTTAACCTTTTTCCCACAACATTTTCTAGGTTTAGCAGGTATACCACGTCGTTACTCAGATTACCCAGACGCCTACACCCTATGAAACGCTATCTCATCTCTTGGATCTTTTATTTCACTAACAGCTGTCATAGTAATAATTTTTATGGTTTGAGAGGCCTTTGCATCCAAACGTGAAGTCCTAACTGTAGAACTAACTTCAACCAACATTGAGTGACTCCACGGATGTCCACCGCCTTACCACACCTTTGAAGAACCGGTATACATTAAAATTTAA

>NC_000891 Ornithorhynchus anatinus (platypus)
ATGTTCATTAACCGCTGACTATTTTCAACTAATCATAAAGATATCGGAACCTTGTATCTTCTATTTGGTGCATGAGCTGGTATAGCCGGCACAGCCCTTAGTATCCTAATTCGATCTGAATTAGGTCAACCCGGTTCATTATTAGGAGATGATCAAATCTATAATGTTATTGTTACAGCCCATGCATTTGTAATAATCTTTTTTATAGTAATGCCCATTATAATTGGTGGTTTTGGTAACTGATTGGTTCCTTTAATAATTGGAGCCCCAGATATAGCATTCCCACGAATAAATAATATGAGCTTTTGACTTTTACCTCCCTCATTTCTCTTACTTTTAGTTTCTTCCACAGTAGAAGCTGGGGCAGGGACAGGCTGAACTGTGTACCCTCCCTTAGCAGGTAACTTAGCCCATGCCGGAGCTTCAGTAGATCTAGCCATTTTTTCTTTACATCTGGCTGGAGTCTCTTCTATTCTAGGGGCAATCAACTTCATTACAACAATTATTAATATGAAGCCACCTGCAATATCACAATACCAGACGCCTCTATTCGTTTGATCAGTCTTAATTACAGCTGTTCTTCTCCTTCTATCCCTTCCTGTTCTTGCAGCAGGTATTACCATGCTCCTGACCGATCGTAATCTCAACACAACTTTCTTTGATCCTGCTGGGGGAGGTGACCCTATCTTATACCAACACTTATTCTGATTTTTTGGTCACCCTGAGGTATATATTTTAATCTTGCCTGGCTTTGGAATTATTTCTCACATTGTCACTTATTACTCAGGTAAAAAAGAACCATTTGGCTATATAGGGATAGTTTGAGCTATAATATCAATTGGATTTTTAGGTTTTATTGTATGAGCCCACCACATATTTACAGTTGGTATAGATGTTGATACACGAGCCTACTTTACATCTGCCACAATAATTATTGCTATTCCCACTGGTGTCAAAGTATTTAGCTGACTTGCTACATTACATGGTGGGGATATCAAATGAACTCCCCCTATACTATGAGCCCTTGGTTTCATCTTTTTATTTACAGTAGGAGGCCTAACAGGCATTGTTCTAGCCAACTCTTCTTTAGATATTATTCTCCACGACACTTATTATGTTGTTGCTCACTTTCATTATGTACTATCTATAGGAGCAGTATTTGCTATTATAGGTGGCTTTGTCCATTGATTCCCCTTGTTATCAGGTTTTACACTTCATCCAACATGAGCAAAAGTCCACTTTACCCTAATATTTGTAGGGGTTAATCTAACCTTTTTTCCTCAACATTTCTTAGGCCTAGCTGGTATACCACGACGCTATTCAGACTACCCAGACGCCTACACACTATGAAATGCCTTATCATCGCTAGGATCATTCGTTTCACTAACAGCAGTTATAGTTATAATTTTCATAATCTGGGAAGCCTTTGCATCCAAACGAGAAGTCTTATCTGTAGAACTTACTACTACTAATATTGAATGACTCCACGGATGTCCACCTCCTTACCACACATTTGAGCAACCCGTATACATCAAAGCCTAA
```

Approximately 160,000,000 years ago, an organism lived which was the common
ancestor of humans, squirrel monkeys, echidna, and platypus. This ancestor
wasn’t a human, squirrel monkey, echidna, or platypus, but some other species
that doesn’t exist anymore. But because we observe these genes that are so
similar to one another in these different species, we hypothesize that their
last common ancestor had this gene in its genome as well, and that the modern
day variants that we observe across these four species derive from the ancestral
gene. As the eons passed and new species arose from the old ones, errors
accumulated in the gene during copying. Most of these errors had no impact on
the function of COI, so were tolerated. When, on the other hand, errors occurred
that caused the COI protein to not function anymore, those organisms likely
wouldn't survive to pass their broken copy of the gene on to the next
generation. The differences we see when we compare the above sequences show us
where these errors, or mutations, may have accumulated. This process of
tolerating mutations that have a neutral impact on protein function, and not
tolerating mutations that have a detrimetnal impact on protein function, gives
rise to the functional variants of the gene that we see across modern day
organisms. Importantly, we don’t have access to the COI sequence from the last
common ancestor of humans, squirrel monkeys, echidna, and platypus (that species
went extinct millions and millions of years ago), so we can’t know for sure what
that sequence looked like.

````{margin}
```{note}
A mutation of the third base in the above sequences from `G` to `T` - in other words, a `G3T` mutation - likely would have been an evolutionary dead end, resulting in an organism who either wouldn't survive long enough to pass its gene on, or whose offspring would be at such a disadvantage that their lineage would eventually die out. What is it about the `G3T` mutation that gives me confidence that it would be so disadvantageous?
```
````

Sequences such as the ones above can be quantitatively compared using the
process of multiple sequence alignment, which is discussed in detail in Part 2
of this book (**coming soon**). In its simplest form, multiple sequence
alignment allows us to tally differences between sequences while accounting for
insertion/deletion mutations (i.e., mutations that cause some bases to be added
or removed), which change the length of the sequences and require them to be
"aligned" to one another for comparison. When we tally differences in sequences
after aligning them, we expect to see fewer differences between more closely
related sequences (such as the human and the squirrel monkey in this example)
and more differences between the more distantly related sequences (such as the
human and the platypus). The number of differences is correlated with the amount
of time that has passed since the last common ancestor of those organisms, and
that allows us to infer evolutionary relationships between organisms from their
DNA sequences.

```{note}
There are some nice online resources that allow you to explore phylogenetic trees built using this approach, or even to build your own. As an exercise, try to use the [MAFFT server](https://mafft.cbrc.jp/alignment/server/) to align the sequences above and build a phylogenetic tree from them. You'll encounter a lot of different options when using this web server - begin by trying to align and build a tree using default parameters. If you don't know what something means, don't worry about it too much for now. You won't break anything, and you're not trying to publish your results, so just experiment.

Does the tree that you generate align with your expectations for the relationships between these organisms?
```

## The Big Tree

This approach of sequencing one or more genes to infer evolutionary
relationships led to a completely new understanding of the “big tree”, the term
I use for the tree of life that relates all cellular organisms to one another.
One of the biggest revelations that resulted from this work was a new
understanding of that unusual group of life: the single-celled organisms. Based
on molecular phylogenetics, we now understand there to be three top-level groups
in the organization of life {cite}`Woese1977-vi`. These groups, called the
domains of life, are the Archaea, Bacteria, and Eukaryotes. These groups
encompass all currently known cellular life and represent our best hypothesis
about deepest evolutionary relationships in the big tree. As far as we know, all
of the Archaea and Bacteria are single-cellular, and most of the Eukaryotes are
single-cellular. All of the multi-cellular organisms that we are aware of,
including humans, are Eukaryotes. Single-cellular organisms, the vast majority
of whom are microbes, actually represent most of the diversity of life on Earth,
and multicellular organisms are really the unusual ones. This was quite an
astonishing finding: until recently, we were barely even aware of most of the
organisms on the planet!

An important omission from the big tree is the viruses. Viruses contain
encapsulated genetic information in the form of DNA or RNA, but can’t reproduce
themselves on their own. In other words, they’re obligate parasites. They
require a host cell to reproduce in, often hijacking the host’s machinery for
replication, and may or may not kill the host cell in the process. Because
viruses can’t replicate on their own it’s debatable whether they’re actually
alive, or just life-like particles that move through the environment replicating
themselves and wreaking havoc on populations of organisms (the SARS-CoV-2 virus,
and the COVID-19 disease that it causes, are a perfect example). While we tend
to think of viruses as attacking animals and plants, there are viruses that
target bacterial and archaea as well and these viruses may be important for
shaping microbiomes.

This molecular approach to inferring evolutionary relationships has also led to
a fascinating view of our own origin. One feature that differentiates the
eukaryotic cell from bacterial and archaeal cells is that eukaryotic cells
contain membrane-bound organelles. Membrane-bound organelles are structures
inside of a cell that contain their own membrane, and serve as compartments
which separate what is happening inside the organelle from what is happening
outside the organelle. The majority of a eukaryotic cell’s DNA is contained
inside of a membrane-bound organelle called the nucleus, and cellular functions
related to DNA replication (for reproduction) or DNA transcription (the initial
reading of the DNA to create molecular machines) happen in the nucleus. This
likely serves the purpose of protecting the DNA and maintaining an environment
that is always conducive to DNA replication and transcription so these functions
can be quickly initiated.

Eukaryotic cells have other membrane-bound organelles in addition to the
nucleus. Two interesting ones are the mitochondria and chloroplast. These
organelles actually have some of their own DNA in them, distinct from the
nuclear DNA (or the DNA found in the nucleus). When molecular phylogenetics
became part of the evolutionary toolkit, researchers sequenced the DNA from
these organelles and found that their closest relatives (based on the distance
to other known DNA sequences) were bacteria! The mitochondria was most closely
related to a group of bacteria called proteobacteria, and the chloroplast was
most closely related to the photosynthesizing cyanobacteria. Given the
similarities of the eukaryotic cell to archaeal cells (for example, structures
in the cell membrane), our current hypothesis is that eukaryotes like us evolved
when an archaeal cell engulfed a bacterial cell, and the two formed a lasting
symbiotic relationship.

## Studying microbiomes

As a side effect of this molecular phylogenetics approach, we began to build up
reference databases that linked names of organisms to the sequence of fragments
of their genomes. In the mid-1980s, Norman Pace and colleagues came up with a
new way to use this information that paved the way for our current understanding
of microbiomes {cite}`Pace1986-il`. They collected samples from the environment,
isolated DNA from those samples, then isolated their “marker gene” of interest
from that DNA, and sequenced it. This would give them lists of DNA sequences
that were observed in a given environment. They could compare those sequences
against known sequences in the reference databases, and end up with lists of
which microbes were present in which sample. This became the basis of comparing
samples based on their taxonomic composition, and was a major catalyst in the
field of microbiome science. Now it was possible to take a sample, say from the
soil, or the human gut, or a hot spring in Yellowstone National Park, and know
what microbes lived in that environment without having to grow those microbes in
the lab. The DNA sequences that were isolated also allowed researchers to
determine which organisms were present without having to observe them through a
microscope or how they reacted to a chemical you added to their environment. The
era of culture-independent investigation of communities of microbes had arrived.

Partial genome sequencing is now a very popular approach for studying
microbiomes. This comes in a few different flavors. Currently the most common
and cost effective approach is marker gene profiling, also referred to as
metabarcoding, (other synonymous terms). In this approach a gene which is
present in all of the targeted organisms, but which differs across those
organisms due to mutations, is isolated from all of the microbial cells in a
sample and sequenced. This typically results in tens of thousands of sequences
of that gene per sample, and the variants that are observed are used as genetic
fingerprints of the organisms that are present in that sample. This approach is
applied to generate descriptions of the taxonomic composition of samples, or
which organisms are present in what relative abundances across a set of samples.
For example, a marker gene profile of an individual’s gut microbiome may tell us
that its composition is 50% Proteobacteria, 35% Firmicutes, and 15%
Bacteroidetes (three different types of bacteria). It doesn’t tell us how many
individual organisms of each type are present though, which presents some
challenges with interpreting these data. The process of isolating the marker
gene can also introduce biases, such that some organisms are more likely to be
observed than others, even if both are present in a sample.

Another approach for applying partial genome sequencing to study microbiomes is
shotgun metagenomic profiling. In this approach, all of the DNA collected from a
sample is targeted for sequencing, rather than just a single marker gene. This
provides some benefits and drawbacks relative to marker gene profiling. First,
it enables not only a view of the taxonomic composition of a sample, but also a
view of what genes are present in the environment. This is important, because
very closely related microbes (even of the same species) can have very different
genes in their genomes, which can in turn impact how they function. For example,
the presence of a single gene can impact whether organisms of the species E.
coli are harmless or pathogenic. This information often won’t be clear from a
marker gene survey, but may be clear from a profile of the functional
composition of a sample derived by sequencing its metagenome. However, a lot
more DNA sequence data must be collected in a shotgun metagenomic survey than in
a marker gene survey, since the former aims to profile all of the genes from all
of the organisms in a sample, and the latter aims to profile one gene from all
of the organisms in a sample. This makes shotgun metagenomics much more
expensive than marker gene profiling.

We’ll revisit the pros and cons of these approaches, and discuss microbial
taxonomy and evaluating the taxonomic and functional composition of samples, in
the other chapters.

## Microbiome multi-omics

As of this writing, many studies are trying to combine marker gene sequencing
and shotgun metagenomics to balance their pros and cons. For example, marker
gene profiling may be applied to all samples in a study, while shotgun
metagenomic profiling is reserved for a few of the samples that are determined
to be most interesting based on the marker gene profiles. Other studies may try
to use shotgun metagenomic sequencing of a few samples as a way to generate
detailed reference data that is then used in combination with marker gene data
from all of the samples to try to approximate the information that would be
gained by shotgun metagenomic profiling of all of the samples.

We are also beginning to integrate other types of data with DNA sequencing-based
profiles of microbiomes. For example, mass spectrometry is now being applied to
profile the small molecules and/or proteins in samples, generating metabolomics
and/or proteomics views of a community. These provide insight into the chemcial
environment of microbiomes, or on what proteins are present. Sequencing of mRNA
molecules in metatranscriptomics surveys provides a view of what transcripts are
present, providing a view into what genes are active in a microbiome. These
approaches try to provide additional information on top of which microbes are
present in an environment: specifically, they aim to profile the activity of
microbiomes.

While QIIME began as a marker gene analysis pipeline, we are expanding to
support analysis of shotgun metagenomics, metatranscriptomics, metaproteomics,
and metabolomics. This is supported in large part by researchers around the
world developing plugins for QIIME 2 - a topic that is covered in Part 3 of this
book. Importantly, as these new technologies become available they tend to not
replace earlier ones but to complement them. Culturing and microscopy are still
important technologies for studying microbes and microorganisms. As we develop
new tools, they expand our toolkit and allow us to learn more about the
microbial world at a quicker pace than we could before.

## List of works cited

```{bibliography} ../references.bib
:filter: docname in docnames
```