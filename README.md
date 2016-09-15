# SMC-RNA DREAM Challenge Webinars - Sept 2016

This repository contains slides and resources to accompany the DREAM Challenge webinars:

[Webinar 1 - Visual Interface](https://www.youtube.com/watch?v=JdCsL_MSOrE)

[Webinar 2 - Python and API](https://www.youtube.com/watch?v=tDzzRq4YN9M)

Documentation for the CGC can be found at the [CGC Knowledge Center](http://docs.cancergenomicscloud.org/).

### Helper Functions

`dream_helpers.py` is a library of helper functions to be used with the Python client of the Seven Bridges API. These functions are used in each notebook. It may be helpful to look through these functions to understand how API calls are made using the Python client.

## Notebooks

To use the notebooks below, you will want to 1. copy the DREAM Challenge Project on the CGC, 2. set up your API environment variables, and 3. change the IDs for username, project, ID, etc. to your own.

### DREAM Notebook
A note which walks through the SMC-RNA DREAM Challenge Public Project, including how to submit tasks in which the `smcIsoform-RSEM-workflow` is run with DREAM Challenge training data. In addition, how to evaluating the outputs of your workflow against truth sets.

### Evaluation Kallisto
This notebook describes how to run `kallisto_quant.cgc.cwl` to evaluate the accuracy of `kallisto quant` with training data.
