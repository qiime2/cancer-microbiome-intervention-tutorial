# QIIME 2 Cancer Microbiome Intervention Tutorial

This repository contains the source for the QIIME 2 Cancer Microbiome
Intervention Tutorial. This content is presented as a [Jupyter Book](https://jupyterbook.org)
[here](https://docs.qiime2.org/jupyterbooks/cancer-microbiome-intervention-tutorial/).

You shouldn't need to access this source repository if you're interested in
following the tutorial or reading other parts of the Jupyter Book.

## About QIIME 2 Usage API enabled Jupyter Books

QIIME 2 Usage API enabled Jupyter Books allow for the development of
Jupyter Books that can illustrate QIIME 2 workflows as steps in different QIIME
2 interfaces.

## For developers and tutorial authors

### Building this Jupyter Book

1. Install the most recent development version of QIIME 2.
   1. macOS
      ```{code-block}
      wget https://raw.githubusercontent.com/qiime2/environment-files/master/latest/staging/qiime2-latest-py38-osx-conda.yml
      conda env create -n q2-jb --file qiime2-latest-py38-osx-conda.yml
      conda activate q2-jb
      ```
   1. Linux
      ```{code-block}
      wget https://raw.githubusercontent.com/qiime2/environment-files/master/latest/staging/qiime2-latest-py38-linux-conda.yml
      conda env create -n q2-jb --file qiime2-latest-py38-linux-conda.yml
      conda activate q2-jb
      ```

1. Obtain Jupyter Book content by cloning this repository and changing into the
   new directory that is created:
   ```{code-block}
   git clone git@github.com:qiime2/cancer-microbiome-intervention-tutorial.git
   cd cancer-microbiome-intervention-tutorial
   ```

1. Install additional dependencies:
   ```{code-block}
   pip install -r book/requirements.txt
   ```

1. Build the book and initiate http server to host the book content:

    ```{code-block}
    make
    ```

1. Open `http://localhost:8000` in your web browser.

1. Read and enjoy. 📚 ☕

### Local Linting

```{code-block}
docker pull github/super-linter:latest
docker run -e RUN_LOCAL=true -e VALIDATE_JSCPD=false -v $PWD:/tmp/lint github/super-linter
```
