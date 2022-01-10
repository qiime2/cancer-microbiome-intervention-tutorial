# 2022.1 QIIME 2 FAES Workshop tutorial

This repository contains the source for the Jan 30 - Feb 4 2022 _Microbiome
Bioinformatics with QIIME 2_ workshop tutorial at FAES.

This content is presented as a [JupyterBook](https://jupyterbook.org) at
**insert URL when available**. You shouldn't need to access this source
repository if you're interested in following the tutorial or reading other
parts of the JupyterBook.

If you're interested in building this JupyerBook on your own computer, or in
building other QIIME 2 Usage-enabled JupyterBooks, instructions follow below.

## QIIME 2 Usage API enabled JupyterBooks

QIIME 2 Usage API enabled JupyterBooks allow for the development of
JupyterBooks that can illustrate QIIME 2 workflows as steps in different QIIME
2 interfaces. This README.md illustrates how to build this particular QIIME 2
Usage API enabled JupyterBooks, and since this is first of these, it also
illustrates how to build your own QIIME 2 Usage API enabled JupyterBook.

### Building this Jupyter Book on your own computer

1. Install the most recent development version of QIIME 2.
   1. macOS
      ```{code-block}
      wget https://raw.githubusercontent.com/qiime2/environment-files/master/latest/staging/qiime2-latest-py38-osx-conda.yml
      conda env create -n 2022-faes-jb --file qiime2-latest-py38-osx-conda.yml
      conda activate 2022-faes-jb
      ```
   1. Linux
      ```{code-block}
      wget https://raw.githubusercontent.com/qiime2/environment-files/master/latest/staging/qiime2-latest-py38-linux-conda.yml
      conda env create -n 2022-faes-jb --file qiime2-latest-py38-linux-conda.yml
      conda activate 2022-faes-jb
      ```

1. Obtain JupyterBook content by cloning this repository and changing into the
   new directory that is created:
   ```{code-block}
   git clone git@github.com:gregcaporaso/2022.1-faes-tutorial.git
   cd 2022.1-faes-tutorial
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
