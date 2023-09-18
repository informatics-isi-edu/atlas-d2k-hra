# atlas-d2k-hra

This repository has been created for integrating [ccf-ui](https://github.com/hubmapconsortium/ccf-ui) with Chaise applications.

## Deploying

1. First you need to setup some environment variables. The following are the variables and their default values:

    ```sh
    CCF_UI_ZIP_LINK=https://github.com/hubmapconsortium/ccf-ui/archive/refs/tags/3.7.2.zip
    CCF_UI_VERSION=3.7.2

    HRA_INSTALL_DIR=/var/wwww/html/apps/hra
    ```
    Notes:
    -
    - If you're deploying remotely, since we're using the `HRA_INSTALL_DIR` in `rsync` command, you can use a remote location `username@host:public_html/` for this variable.

2. The following command will download the `ccf-ui` based on the given link in `CCF_UI_ZIP_LINK` variable, and will unzip its content into the `ccf-ui` folder that the code relies on.

    ```sh
    make dist
    ```

    Notes:
    - Make sure to run this command with the owner of the current folder. If you attempt to run this with a different user, it will complain.
    - `CCF_UI_VERSION` is used to find out which version of `ccf-ui` is currently installed. If you've already ran `make dist` before and havent' changed this variable, we will skip the download step. If you would like to force a download you should update this variable.

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
3. Change the value of `CCF_UI_ZIP_LINK` in `Makefile` to be the link that you grabbed.
4. Update `CCF_UI_VERSION` value in `Makefile`. We're using this version to make sure we're not downloading this file multiple times.
5. Update the default values noted in the [deploying section](#deploying).
6. Commit your changes and push.

The build recipes will then pull the latest code and install the version that you noted in the Makefile.

## Help and Contact

Please direct questions and comments to the [project issue tracker](https://github.com/informatics-isi-edu/atlas-d2k-hra/issues).
## License

This repsitory made available as open source under the Apache License, Version 2.0. Please see the [LICENSE file](LICENSE) for more information. It uses [ccf-ui](https://github.com/hubmapconsortium/ccf-ui) and you can find its license file [here](CCF_UI_LICENSE).

## About Us

Chaise is developed in the [Informatics Systems Research group](https://www.isi.edu/isr/) at the [USC Information Sciences Institute](http://www.isi.edu).
