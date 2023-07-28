#!/usr/local_rwth/bin/zsh

#SBATCH --job-name=whatever
### if you filed a project:
### SBATCH --account=thes1324
### Else you have to enter a partition
#SBATCH --partition=c18g
#SBATCH --output=output/output.%J.txt

#SBATCH --time=0-00:05:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=24
#SBATCH --mem-per-cpu=4G

### Note: If you take 1 GPU, you're automatically assignes 24 Cores.
### This means, you will use 24 core hours from your account per hour.

export CONDA_ROOT=$HOME/miniconda3
. $CONDA_ROOT/etc/profile.d/conda.sh
export PATH="$CONDA_ROOT/bin:$PAHTH"

module load CUDA/11.3.1
module load GCC/9.3.0

conda activate YOUR ENV
python YOUR CODE

### Job submission: sbatch < jobscript.sh
### sacct -X                      to see your recent jobs (pending/running/completed)
### squeue -u $USER --start       expected time when the job starts
### r_wlm_usage -q           overview of your account. It might take 2-3 days after your first job
