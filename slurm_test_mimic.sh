#!/bin/bash
#SBATCH -p bme_gpu
#SBATCH --job-name=r2g
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=64G
#SBATCH -t 5-00:00:00
source activate idea
nvidia-smi

PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
python main_test.py \
        --image_dir /public_bme/data/physionet.org/files/mimic-cxr-jpg/2.0.0/files/ \
        --ann_path /public_bme/data/physionet.org/files/mimic-cxr-jpg/2.0.0/annotation.json \
        --dataset_name mimic_cxr \
        --max_seq_length 100 \
        --threshold 10 \
        --epochs 30 \
        --batch_size 1 \
        --lr_ve 1e-4 \
        --lr_ed 5e-4 \
        --step_size 3 \
        --gamma 0.8 \
        --num_layers 3 \
        --topk 32 \
        --cmm_size 2048 \
        --cmm_dim 512 \
        --seed 9153 \
        --beam_size 3 \
        --save_dir ./results/mimic_cxr \
        --log_period 1000 \
        --load ../pre-models/r2gcmn_mimic-cxr.pth
