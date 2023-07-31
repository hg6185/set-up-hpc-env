# set-up-hpc-env
This is a short tutorial on how to set up an hpc account and how to install your environment. For more information find documentation of itc.rwth-aachen.de

## Register Account and Register SSH Keys
1.	Register an account: https://regapp.itc.rwth-aachen.de/ and login with single-sign

2.	If you dont have a SSH-key already type the following and hit enter three times:

```
ssh-keygen -t ed25519
```

3.	To facilitate the connection navigate to your .ssh folder (usually home/.ssh) and type "dir" to check wether your keys were generated accordingly. Next of (in .ssh):

```
Notepad config.txt
```

Change ab123456 with your 'tim-kennung'

```
Host rwth-gpu-cluster
  HostName ab123456@login18-g-1.hpc.itc.rwth-aachen.de
  User ab123456
  IdentityFile ~/.ssh/id_ed25519

```

You can now open the connection by clicking on your left lower corner in VS CODE. Wait for the installation to complete and initiate the connection with a new host. Note that since you already wrote the config file, VS CODE should suggest our configured connection to rwth-gpu-cluster

## Installing Environments

As it can be seen in the itc documentation of the hpc, there are many ways on how to handle this task. Personally, I find using miniconda very easy:

1. Install miniconda

```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

```
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init zsh
```

2. Create a new conda environement

```
conda create -n fps-bm python=3.8
conda activate fps-bm
```

3. Install Cuda-Drivers (nvidia-smi reveals that cuda version is 12).
Pytorch support surely higher versions but I have run into a lot of trouble.
You can checkout available versions of cuda and gcc with "module spider cuda".
For me this works:

```
module load CUDA/11.3.1
```

nvcc demands gcc version <10:

```
module load GCC/9.4.0
```

```
conda install -c conda-forge cudatoolkit=11.3
```

4. Install pytorch with cuda support

```
conda install pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia
```

## The Slurm System

When you connect to via SSH, you will connect to the log-in node. However usually, you might wanna use the SLURM system to send jobs. You have an account with core-hours that you can use (Students 500 / Hiwis - Assis 2000). For more details or how to file a project request, see the itc-website.
Place the jobscript.sh in your main directory and configure cmd commands in there.
All necessary commands will be explained in this file!!

Finally create a directory (on the same level as the jobscript) and name it output.

## Data Transfer

SFTP -> Mac: CyberDuck, WinSCP
ab123456@copy18-1.hpc.itc.rwth-aachen.de

## Known Issues

CUDA drivers might not always be compatible with GCC, but so do libs:
Matplotlib 3.1.1 can be used with GCC9.4.0 as it is the latest stable release for python 3.8. Higher versions work with higher gcc drivers. If you encounter an issue, please report it so it can be added here in this section.
