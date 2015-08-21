# Development Setup

If you would like to work on developing these cookbooks, follow the steps below. If you are only intersted in deploying the app, you need not complete these steps.

1. Install Vagrant

    Follow instructions on [http://vagrantup.com](http://vagrantup.com).

2. Start a new Virtual Machine

    ```
    $ vagrant up
    ```

3. Add vagrant to your ssh-config

    ```
    $ vagrant ssh-config --host vagrant >> ~/.ssh/config
    ```

4. Prepare the VM

    ```
    $ librarian-chef install
    $ knife solo prepare vagrant
    ```

5. Cook the recipes

    ```
    $ knife solo cook vagrant -N vagrant
    ```


## AWS EC2

1 Create a new EC2 instance and put your Key Pair .pem file into the root directory of this project with the name ttt.pem


    ttt.pem

2 Turn on SSH ForwardAgent for the EC2 instance by adding the following to your ~/.ssh/config file. The Host should be the public IP of your EC2 instance


     Host 12.345.67.89
       ForwardAgent yes

3 Run the following rake tasks to install the Ruby 2.2.2, clone your git repo and start `thin` server on port 3000

    $ rake prepare:staging
    $ rake deploy:staging


4 Use the following command to pull any changes from master and redeploy your web application

    $ rake deploy:staging
