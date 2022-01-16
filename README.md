# 2022.1 QIIME 2 FAES Workshop tutorial source

This repository contains the source for the Jan 30 - Feb 4 2022 _Microbiome
Bioinformatics with QIIME 2_ workshop tutorial at FAES. This content is
presented as a [Jupyter Book](https://jupyterbook.org)
[here](https://qiime2-workshops.s3.us-west-2.amazonaws.com/faes-jan2022/index.html).

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
      conda env create -n 2022-faes-jb --file qiime2-latest-py38-osx-conda.yml
      conda activate 2022-faes-jb
      ```
   1. Linux
      ```{code-block}
      wget https://raw.githubusercontent.com/qiime2/environment-files/master/latest/staging/qiime2-latest-py38-linux-conda.yml
      conda env create -n 2022-faes-jb --file qiime2-latest-py38-linux-conda.yml
      conda activate 2022-faes-jb
      ```

1. Obtain Jupyter Book content by cloning this repository and changing into the
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
    make build_full
    ```

1. Open `http://localhost:8000` in your web browser.

1. Read and enjoy. 📚 ☕

### Local Linting

```{code-block}
docker pull github/super-linter:latest
docker run -e RUN_LOCAL=true -e VALIDATE_JSCPD=false -v $PWD:/tmp/lint github/super-linter
```
