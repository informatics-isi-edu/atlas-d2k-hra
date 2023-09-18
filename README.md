# atlas-d2k-hra

This repository has been created for integrating [ccf-ui](https://github.com/hubmapconsortium/ccf-ui) with Chaise applications.

## Deploying

1. First you need to setup some environment variables. The following are the variables and their default values:

    ```sh
    RELEASE_LINK=https://github.com/hubmapconsortium/ccf-ui/archive/refs/tags/3.7.2.zip
    CCF_UI_FOLDER=ccf-ui-3.7.2

    HRA_INSTALL_DIR=/var/wwww/html/apps/hra
    ```
    Notes:
    -
    - If you're deploying remotely, since we're using the `HRA_INSTALL_DIR` in `rsync` command, you can use a remote location `username@host:public_html/` for this variable.

2. The following command will download the `ccf-ui` based on the given link in `RELEASE_LINK` variable, and will unzip its content into the folder using `CCF_UI_FOLDER` name.

    ```sh
    make dist
    ```

    Notes:
    - Make sure to run this command with the owner of the current folder. If you attempt to run this with a different user, it will complain.
    - We will skip downloading if a folder with `CCF_UI_FOLDER` name already exists.

3. To deploy the package, run the following:

    ```sh
    make deploy
    ```

    Notes:
      - If the given directory does not exist, it will first create it. So you may need to run `make deploy` with _super user_ privileges depending on the installation directory you choose.

## Updating ccf-ui

If you would like to update the included ccf-ui, you should

1. Find the version that you'd like from their [GitHub releases page](https://github.com/hubmapconsortium/ccf-ui/releases).
2. Grab the link of `Source code (zip)`.
3. Change the value of `RELEASE_LINK` in `Makefile` to be the link that you grabbed.
4. Update `CCF_UI_FOLDER` value in `Makefile`. To make sure we're not downloading this file multiple time, you should include the version name in this value.
5. Update the default values noted in the [deploying section](#deploying).
6. Update the `.html` files to point to the new folder.
   - In `rui.html`:
      1. Update line 11 and 12.
      2. Update line 14.


## Help and Contact

Please direct questions and comments to the [project issue tracker](https://github.com/informatics-isi-edu/atlas-d2k-hra/issues).
## License

This repsitory made available as open source under the Apache License, Version 2.0. Please see the [LICENSE file](LICENSE) for more information. It uses [ccf-ui](https://github.com/hubmapconsortium/ccf-ui) and you can find its license file [here](CCF_UI_LICENSE).

## About Us

Chaise is developed in the [Informatics Systems Research group](https://www.isi.edu/isr/) at the [USC Information Sciences Institute](http://www.isi.edu).
