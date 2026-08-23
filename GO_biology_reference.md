# What the GO Terms Mean

This is my own notes on what each GO term from the enrichment plots actually means, so I (and anyone reading this) can understand the biology behind the results, not just the plot.

## Downregulated genes (1 uM) - genes that got shut off

### Cell cycle and cell division

These are all about a cell copying itself and splitting into two:

- Cell cycle / cell cycle process - the general repeating process a cell goes through: grow, copy its DNA, split into two cells. This is the umbrella term.
- Mitotic cell cycle / mitotic cell cycle process - the actual division part of that cycle.
- Cell division - the physical splitting of one cell into two.
- Cell cycle phase transition - the checkpoints a cell has to pass through to move from one stage to the next. If something's wrong, the cell pauses here instead of moving forward.
- Regulation of cell cycle / regulation of cell cycle process - genes that control when the cycle happens.


### Pulling chromosomes apart

Once a cell has copied its DNA, it needs to physically pull the two copies apart before splitting:

- Chromosome segregation / nuclear chromosome segregation - pulling the duplicated chromosomes to opposite ends of the cell.
- Sister chromatid segregation / mitotic sister chromatid segregation - each duplicated chromosome is actually two identical halves stuck together (sister chromatids). This is splitting that pair apart.
- Nuclear division / mitotic nuclear division / organelle fission - the nucleus itself splitting in two.
- Chromosome organization - packaging chromosomes correctly before they get pulled apart.
- Kinetochore / condensed chromosome / chromosome centromeric region / condensed chromosome centromeric region - these are all about the physical structures on a chromosome. The centromere is the pinch point, and the kinetochore is the protein "handle" that attaches there so the cell's machinery can grab and pull it.
- Spindle / mitotic spindle / spindle pole / centrosome / microtubule organizing center - the spindle is the structure that physically reaches out and pulls chromosomes apart. The centrosome is where it anchors from.
- Microtubule / microtubule cytoskeleton / tubulin binding / microtubule binding / cytoskeletal protein binding - microtubules are the actual protein fibers the spindle is made of. Tubulin is the building block.

### Copying and fixing DNA

- DNA repair / DNA damage response - the system that finds and fixes broken DNA.
- DNA metabolic process - general term covering DNA copying and repair.
- Replication fork - the actual point on the DNA where it's being copied (like a zipper being pulled open while new DNA gets built).
- Helicase activity - the job of unzipping the two DNA strands apart so they can be copied or repaired.
- Catalytic activity acting on DNA / ATP-dependent activity acting on DNA - general terms for enzymes that work directly on DNA using cell energy.

### The molecular toolkit

- DNA binding / nucleic acid binding - just means the protein can physically attach to DNA or RNA. Needed before you can repair, copy, or move it.
- ATP binding, ATP hydrolysis activity, ATP-dependent activity, adenyl nucleotide binding, purine nucleotide binding, nucleotide binding, and similar terms - these are all versions of the same idea: ATP is the cell's energy source, and most of the machinery above (spindle, helicase, repair enzymes) needs to burn ATP to actually do its job. Seeing a lot of these together fits with the idea that these are active, energy-using molecular machines.
- Enzyme binding - these proteins work together with other enzymes, not alone.

### How this all fits together

Basically: before a cell can divide, it copies its DNA (repair/replication genes) -> packages the chromosomes (chromosome organization) -> builds a spindle out of microtubules (centrosome, spindle, tubulin) -> attaches the spindle to each chromosome (kinetochore) -> pulls them apart (chromosome segregation) -> and finishes dividing (cell division). Every step of this whole chain shows up as downregulated, which is why I'm reading this as "cell division is being shut down," not just one small piece of it.

## Upregulated genes (1 uM) - genes that turned on

### p53 stress signaling

- Intrinsic apoptotic signaling pathway (by p53 class mediator / in response to DNA damage) - p53 is a well known gene that acts like a damage checkpoint. If a cell has serious DNA damage, p53 can trigger the cell to self-destruct (apoptosis) rather than risk it becoming a broken, malfunctioning cell.
- Signal transduction by p53 class mediator - the signal relay that carries the "damage detected" message.
- Apoptotic process - the general programmed cell death pathway.
- Intracellular signal transduction, regulation of signal transduction, regulation of signaling, regulation of cell communication, etc - this is the general messaging system inside cells. The p53 pathway above is one specific example running through this general system.

This connects to the downregulated side - a stress signal turning on at the same time as division machinery turns off is a pretty classic "growth arrest" pattern.

### Turning into a specific cell type (differentiation)

- Tissue development / animal organ development / cellular developmental process / cell differentiation - differentiation is when a generic dividing cell instead commits to becoming a specific, specialized cell type - and usually stops dividing to do it.
- Epithelium development / epithelial cell differentiation / epidermis development - epithelial cells are the type that line surfaces (skin is the obvious example, and MCF-7 itself comes from this type of tissue). This suggests the cells are shifting toward a more "mature skin-type cell" identity instead of continuing to act like dividing cancer cells.

### Structural genes (matching the differentiation theme)

- Extracellular matrix (ECM), collagen-containing extracellular matrix, extracellular region, extracellular space, external encapsulating structure - the ECM is the structural scaffolding outside cells - things like collagen that hold tissue together.
- Basement membrane / laminin complex - a specific type of ECM that sits right under epithelial cells and anchors them in place.
- Keratin filament / structural constituent of skin epidermis / structural molecule activity - keratins are the main structural proteins in skin cells. This is a pretty direct confirmation of the "becoming more epithelial/skin-like" theme above.
- bHLH transcription factor binding, protein dimerization/heterodimerization/homodimerization activity, molecular function activator/regulator activity - these are regulatory proteins that control differentiation decisions - the "control switches" behind the differentiation program.

### Hormone/steroid metabolism enzymes

- Alcohol dehydrogenase activity, aldo-keto reductase activity, ketosteroid monooxygenase activity, 5alpha-androstane-3beta,17beta-diol dehydrogenase activity, vitamin D 24-hydroxylase activity, monocarboxylic acid binding - these are metabolic enzymes mostly involved in processing steroid hormones. Since this whole experiment is about an estrogen receptor agonist, it makes sense the cell would also be adjusting how it processes hormones/steroids in response. I'm treating this as a real but secondary finding, not the main story.

### Terms to be careful with
Endothelin b receptor binding, bombesin receptor binding, and a few of the "activator/regulator activity" terms had really high fold enrichment numbers, but when I checked, they were only based on 2 genes each out of very small categories. That's an easy way to get a big-looking number by chance, so I'm not treating these as solid findings - just noting them.

### How this all fits together

The upregulated side reads as: a p53 stress signal turning on, which lines up with the cell moving toward a differentiation program (becoming more epithelial/skin-like), which comes with building structural proteins (keratins) and attaching to a basement membrane. There's also a smaller, separate signal about hormone-processing enzymes, which makes sense given the treatment itself is a hormone receptor agonist.

### Putting both sides together

At 1 uM, the cell's division machinery (DNA repair, chromosome segregation, spindle apparatus) gets broadly shut down, while a stress response and a differentiation program turn on at the same time. That combination - division off, stress/differentiation on - is a pretty recognizable signature of a cell going into growth arrest. This didn't happen at 100 nM, which is why I think there's a dose threshold involved rather than a smooth dose-response.