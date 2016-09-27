# SMC-RNA DREAM Challenge Webinars

This repository contains slides and resources to accompany the [DREAM Challenge](http://www.cancergenomicscloud.org/dreamchallenge/) webinars:

* [Webinar 1 - Visual Interface](https://www.youtube.com/watch?v=JdCsL_MSOrE)

* [Webinar 2 - Python and API](https://www.youtube.com/watch?v=tDzzRq4YN9M)

Documentation for the Seven Bridges Cancere Genomics Cloud can be found at the [CGC Knowledge Center](http://docs.cancergenomicscloud.org/v1.0/docs/dream-challenge).

### Helper Functions

`dream_helpers.py` is a library of helper functions to be used with the [Python client of the Seven Bridges API](https://github.com/sbg/sevenbridges-python). These functions are used in each notebook. It may be helpful to look through these functions to understand how API calls are made using the Python client.

## Notebooks

Before usig the notebooks below, you will want to do the following:
1. [Copy](http://docs.cancergenomicscloud.org/v1.0/docs/dream-challenge#section-copy-the-icgc-tcga-dream-somatic-mutation-calling-public-project) the DREAM Challenge Project on the CGC visual interface.
2. [Set up](https://github.com/sbg/okAPI/blob/master/Tutorials/SBPLAT/Setup_API_environment.ipynb) your API environment variables.
3. Change the IDs for username, project, ID, etc. in the notebooks to your own.

### DREAM Notebook
This walks through the SMC-RNA DREAM Challenge Public Project and includes instructions on how to submit tasks in which the `smcIsoform-RSEM-workflow` is run with DREAM Challenge training data. In addition, this notebook demonstrates how to evaluate the outputs of your workflow against truth sets.

### Evaluating Kallisto
This notebook describes how to run `kallisto_quant.cgc.cwl` to evaluate the accuracy of `kallisto quant` with training data.
