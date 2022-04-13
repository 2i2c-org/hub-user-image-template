# hub-user-image-template :paperclip:

This is a template repository for creating dedicated user images for 2i2c hubs.

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Overall workflow](#overall-workflow)
- [About this template repository](#about-this-template-repository-information_source)
  - [Environment](#the-environment)
  - [Workflows](#the-github-workflows)
    - [build.yaml](#1-build-and-push-container-image-arrow_right-buildyaml)
    - [test.yaml](#2-test-container-image-build-arrow_right-testyamll)
    - [binder.yaml](#3-test-this-pr-on-binder-badge-arrowright-binderyaml)
- [How to create and use a custom user image for your hub](#how-to-create-and-use-a-custom-user-image-for-your-hub-gear)
  - [Use this template](#1-use-this-template)
  - [Hook the new repository to quay.io](#2-hook-the-new-repository-to-quayio)
  - [Enable image push to quay.io](#3-enable-image-push-to-quayio)
      - [Enable quay.io image push for build.yaml](#enable-quayio-image-push-for-buildyaml)
      - [Enable quay.io image push for test.yaml](#enable-quayio-image-push-for-testyaml)
  - [Customize the image](#4-customize-the-image)
  - [Build and push the image](#5-build-and-push-the-image)
  - [Connect the hub with this user image](#6-connect-the-hub-with-this-user-image)
  - [Test the new image](#7-test-the-new-image)
- [Push image to a registry other than Quay.io](#push-image-to-a-registry-other-than-quayio-cloud)

<!-- /TOC -->

## Overall workflow

The overall workflow is to:

1. [Fork this repository to create your image repository](#1-use-this-template)

2. [Hook your image repository to quay.io](#2-hook-the-new-repository-to-quayio)

3. [Customize the image](#4-customize-the-image) by editing repo2docker files in your image repository.

   Changes can either be done by direct commits to main on your image repository, or through a pull request from a fork of your image repository. Direct commits will build the image and push it to Quay.io. PRs will build the image and offer a link to test it using Binder. Merging the PR will cause a commit on main and therefore trigger a build and push to Quay.io.

4. [Configure your Hub to use this new image](#6-connect-the-hub-with-this-user-image)

The steps are explained in detail below.

## About this template repository :information_source:

This template repository enables [jupyterhub/repo2docker-action](https://github.com/jupyterhub/repo2docker-action).
This GitHub action builds a Docker image using the contents of this repo and pushes it to the [Quay.io](https://quay.io/) registry.

### The environment

It provides an example of a `environment.yml` conda configuration file for repo2docker to use.
This file can be used to list all the conda packages that need to be installed by `repo2docker` in your environment.
The `repo2docker-action` will update the [base repo2docker](https://github.com/jupyterhub/repo2docker/blob/HEAD/repo2docker/buildpacks/conda/environment.yml) conda environment with the packages listed in this `environment.yml` file.

**Note:**
A complete list of possible configuration files that can be added to the repository and be used by repo2docker to build the Docker image, can be found in the [repo2docker docs](https://repo2docker.readthedocs.io/en/latest/config_files.html#configuration-files).

### The GitHub workflows

This template repository provides two GitHub workflows that can build and push the image to quay.io when configured.

![Workflows](images/workflows.png)

#### 1. Build and push container image :arrow_right: [build.yaml](https://github.com/2i2c-org/hub-user-image-template/blob/main/.github/workflows/build.yaml)

This workflow is triggered by every pushed commit on the main branch of the repo (including when a PR is merged).
It **builds** the image and **pushes** it to the registry.

#### 2. Test container image build :arrow_right: [test.yaml](https://github.com/2i2c-org/hub-user-image-template/blob/MAIN/.github/workflows/test.yaml)

This workflow is triggerd by every Pull Request commit and it **builds** the image, but it **doesn't** push it to the registry, unless explicitly configured to do so. Checkout [this section](#enable-quayio-image-push-for-testyaml) on how to enable image pushes on Pull Requests.

#### 3. Test this PR on Binder Badge :arrow_right: [binder.yaml](https://github.com/2i2c-org/hub-user-image-template/blob/MAIN/.github/workflows/binder.yaml)

This workflow posts a comment inside a pull request, every time a pull request gets opened. The comment contains a "Test this PR on Binder" badge, which can be used to access the image defined by the PR in [mybinder.org](https://mybinder.org/).

![Test this PR on Binder](images/binder-badge.png)

## How to create and use a custom user image for your hub :gear:

Checkout the 2i2c docs for an in-depth guide on how to use this template repositoru to create a custom user image and use it for your hub :arrow_right: https://docs.2i2c.org/en/latest/admin/howto/hub-user-image-template-guide.md.
