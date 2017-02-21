This is a dataset of 32524 examples for premise selection based on the
Mizar40 experiments [1]. The proof data (without the negative part
added here) served also for the DeepMath experiments described in [2].

For each conjecture the dataset contains a file with a roughly equal
number of unnecessary facts and necessary facts. This is done to
simplify experiments with learning methods such as neural networks.

In nnhpdata/* the examples are in this format:

C prefixformula
+ prefixformula
...
+ prefixformula
- prefixformula
...
- prefixformula

In nndata/* the examples are in this format:

C tptpformula
+ tptpformula
...
+ tptpformula
- tptpformula
...
- tptpformula

Here tptpformula is the standard FOL TPTP representation, and
prefixformula is a prefix curried format using de Bruijn indeces.

C is the conjecture, + are the formulas needed for an ATP proof of C,
and - are unnecessary formulas that are reasonably highly ranked by a
k-nearest neighbor algorithm trained on the proofs .

To divide into training and testing, just randomly select a part
(e.g. 90%) of the files to train on and test on the remaining files.

The mizar40 and code directories contain the data (proofs, statemnts,
etc.) and the code used to generate the nndata and nnhpdata examples.

[1] http://dx.doi.org/10.1007/s10817-015-9330-8 
[2] https://arxiv.org/abs/1606.04442