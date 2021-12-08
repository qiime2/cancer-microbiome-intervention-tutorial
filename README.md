# 2022.1 QIIME 2 FAES Workshop tutorial

This repository contains the source for the Jan 30 - Feb 4 2022 _Microbiome Bioinformatics with QIIME 2_ workshop tutorial at FAES. 

This content is presented as a [JupyterBook](https://jupyterbook.org) at **insert URL when available**. You shouldn't need to access this source repository if you're interested in following the tutorial or reading other parts of the JupyterBook. 

If you're interested in building this JupyerBook on your own computer, or in building other QIIME 2 Usage-enabled JupyterBooks, instructions follow below. 

## QIIME 2 Usage API enabled JupyterBooks

QIIME 2 Usage API enabled JupyterBooks allow for the development of JupyterBooks that can illustrate QIIME 2 workflows as steps in different QIIME 2 interfaces. This README.md illustrates how to build this particular QIIME 2 Usage API enabled JupyterBooks, and since this is first of these, it also illustrates how to build your own QIIME 2 Usage API enabled JupyterBook.   

### Building this (or your own) Jupyter Book on your own computer. 

1. Install QIIME 2 following the instructions in the QIIME 2 documentation [here](https://docs.qiime2.org/2021.11/install/native/).

2. Install JupyterBook following the instructions in the JupyterBook documentation [here](https://jupyterbook.org/start/overview.html).

3. Install the most recent development version of the QIIME 2 Sphinx extension (q2doc) in developer mode:

    ```{code-block}
    git clone git@github.com:qiime2/sphinx-ext-qiime2.git
    pip install -e .
    ```

4. Obtain **or** create JupyterBook content:
    1. To build this JupyterBook on your computer, clone this repository and change into the new directory that is created:
        ```{code-block}
        git clone git@github.com:gregcaporaso/2022.1-faes-tutorial.git
        cd 2022.1-faes-tutorial
        ```
    2. Alternatively, to create your own JupyterBook:
        1. Start by [creating a template JupyterBook](https://jupyterbook.org/start/create.html): 
            ```{code-block}
            jupyter-book create book/
            ```
        2. Edit `book/_config.yml`, adding the following to the bottom of the document:
            ```{code-block}
            sphinx:
            extra_extensions          :   ["q2doc.usage"]
            config                    :   {'html_baseurl': 'http://localhost:8000'}
            ```

5. Clean up remnants from previous builds; build the book; and initiate http server to host the book content:

    ```{code-block}
    jupyter-book clean book && jupyter-book build book && cd book/_build/html/ && python -m http.server && cd -
    ```

6. Open http://localhost:8000 in your web browser.

7. Read and enjoy. 📚 ☕