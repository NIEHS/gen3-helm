# Running Gen3 On A Laptop, For Devs

## Welcome
Welcome to Gen3! If you're reading this, I assume you're a developer looking to get started working with Gen3. If so, this guide will help you get an instance of Gen3 up and running on your laptop, which will let you work on Gen3 from anywhere you can write code, no other setup needed. 


### Intro to Kubernetes
Kubernetes is a container orchestrator, and you'll often see it referred to as k8s, or 'k', followed by the 8 letters in 'ubernete', followed by 's'. It is responsible for managing the lifecycle, storage, and networking for a collection of containers, which are packaged into discrete units called "pods". 

If you're not familiar with containers, they're a set of technologies that allow you to run code inside isolated environments on your machine. This provides benefits such as allowing you to manage "machnes" that only exist in software, instead of physical hardware, and isolating applications from each other, to prevent failures from affecting other applications or even all applications on your machine. These are the basic units software that Kubernetes starts up, stops, and schedules, in order to match a state that you define and provide it. 

Kubernetes is primarly meant to run on cloud services, and the big 3 (Amazon Web Services, Microsoft Azure, and Google Cloud) all have robust offerings. While it is designed to run primarily on the cloud, for the sake of developers' ability to work almost anywhere, there are versions (also called flavors) of Kubernetes designed primarily with the laptop or local desktop in mind. The next section will introduce you to the one we'll recommend you use, Rancher Desktop. However you can use another flavor if you think it works better, so long as you can follow the rest of these directions while using them.  

### Installing Kubectl
Kubectl (I pronounce it cube-cuddle, but others say it differently) is an application that allows you to interface with and control a Kubernetes cluster. In this context, "cluster" simply refers to a group of machines, which can be a group of one, that work together to manage containers. It will be an important tool for you as you get more comfortable working with Kubernetes, so we'll install it now. It is a highly-configurable tool that you can install in a lot of ways, so rather than tell you how to do it, we'll let you pick the method that works best for your platform: [Windows](https://kubernetes.io/docs/tasks/tools/install-kubectl-windows) [Mac](https://kubernetes.io/docs/tasks/tools/install-kubectl-macos) [Linux](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux). Once you have kubectl installed, you can verify by running `kubectl`. The output should be a help guide. 

# Do we want this to be Rancher, or Minikube? The command line nature of Minikube means we could build scripts for it, and our local ingress setup is built for Minikube

### Installing Rancher Desktop
This guide is primarily written with Mac users in mind, but most Linux users should be able to install Rancher Desktop using their distro's package manager. If you're on Mac and using Homebrew, you can type `brew install --cask rancher`. If not, install directions for Linux, Mac, and Windows are available at [the Rancher website.](https://docs.rancherdesktop.io/getting-started/installation/#macOS) Once you have Rancher succesfully installed and the application opened, we can go over how to get your Kubernetes cluster ready for Gen3!

### Configuring Rancher Desktop
![image](rancherReadyForSetup.png)

Once you can see a blank screen like this, you are ready to begin. If you can't get a screen similar to this, without any warnings, reach out to a Gen3 resource, either the community, or the platform team if you work directly for us. Now, we're going to make a few small tweaks to help Kubernetes run better.

Click on the gear icon in the top right of your window, then navigate to "virtual machine." These settings control the VM that Kubernetes is going to run on on your laptop, and so striking a the right balance between performance and resource usage is key.

This guide was developed by people mostly using M1 Macbook Pros with 16GB of RAM and and 8 CPU cores. In a similar situation, this guide recommends allocating half of each (so 8GB of RAM/4 CPU cores) to allow you to run other applications while still deploying all of our services quickly.

Once you've settled on a CPU and RAM allocation, click on the "Kubernetes" tab. Make sure that Kubernetes is enabled, and the version is set appropriately (if you're not sure, just leave it default).

Now that you have these steps out of the way, in our next step, we'll install Helm onto our laptop. Helm is a tool for packaging Kubernetes services, much like a Linux package manager or Homebrew for Mac. This will allow us to more easily install Gen3 onto our laptops. 

### Installing Helm
The installation steps for Helm are rather straightforward. If you're a Homebrew user on Mac, you can use the command `brew install helm` to get it on your machine. If not, head over to the Helm website [here](https://helm.sh/docs/intro/install/) and follow the instructions for your setup. You'll know you've set it up correctly if the output of running the command `helm list` looks like this:

![image](succesfulHelmOutput.png)

This means that Helm was able to connect to your Rancher k8s cluster, and will be able to install Gen3 in the next step.

### Installing Gen3
The first step to installing Gen3 is adding the Gen3 Helm repository. This is just how we package up all the components that make up Gen3, and make them accessible to the public. The command to do this is: `helm repo add gen3 http://helm.gen3.org`. Once you have your repo added, you can install it with the command `helm upgrade --install gen3 gen3/gen3`. This command calls out to the repository you created before, named `gen3`, and grabs an "umbrella chart" containing all the services needed to run Gen3. Confusingly, this umbrella chart is also called `gen3`, and these two parts combine to form the `gen3/gen3` in the command you see. The first `gen3` in that command refers to the "release name," or what Helm will call the deployment of Gen3 on your laptop. If that command runs successfully, you will see an output like this: 

![image](helmSuccesfulGen3Install.png)

### Accessing Gen3 
We need instructions on how to set up access to the frontend.