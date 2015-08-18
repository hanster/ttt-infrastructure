# Development Setup

If you would like to work on developing these cookbooks, follow the steps below. If you are only intersted in deploying the app, you need not complete these steps.

1. Install Vagrant

    Follow instructions on [http://vagrantup.com](http://vagrantup.com).

2. Start a new Virtual Machine

    ```bash
    $ vagrant up
    ```

3. Add vagrant to your ssh-config

    ```bash
    $ vagrant ssh-config --host vagrant >> ~/.ssh/config
    ```

4. Prepare the VM

    ```bash
    $ librarian-chef install
    $ knife solo prepare vagrant
    ```

5. Cook the recipes
    ```base
    $ knife solo cook vagrant -N vagrant
    ```
