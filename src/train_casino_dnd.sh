CUDA_LAUNCH_BLOCKING=1 CUDA_VISIBLE_DEVICES=0 python train.py  --data data/final_casino_dndformat --cuda --bsz 16  --clip 0.5  --decay_every 1  --decay_rate 5.0  --dropout 0.5  --init_range 0.1  --lr 1  --max_epoch 30  --min_lr 0.01  --momentum 0.1  --nembed_ctx 64  --nembed_word 256  --nesterov  --nhid_attn 256  --nhid_ctx 64  --nhid_lang 128  --nhid_sel 256  --nhid_strat 128  --sel_weight 0.5  --model_file ../logs/casino_dndformat_supervised_30ep.pt

echo SELFISH

CUDA_LAUNCH_BLOCKING=1 CUDA_VISIBLE_DEVICES=0 python reinforce.py --cuda --data data/final_casino_dndformat --bsz 16 --clip 1 --context_file data/final_casino_dndformat/selfplay.txt --eps 0.0 --gamma 0.95 --lr 0.5 --momentum 0.1 --nepoch 4 --nesterov --ref_text data/final_casino_dndformat/train.txt --rl_clip 1 --rl_lr 0.2 --score_threshold 6 --sv_train_freq 4 --temperature 0.5 --alice_model ../logs/casino_dndformat_supervised_30ep.pt --bob_model ../logs/casino_dndformat_supervised_30ep.pt --rw_type own_points --output_model_file ../logs/casino_dndform_rl_selfish_4ep.pt

echo FAIR

CUDA_LAUNCH_BLOCKING=1 CUDA_VISIBLE_DEVICES=0 python reinforce.py --cuda --data data/final_casino_dndformat --bsz 16 --clip 1 --context_file data/final_casino_dndformat/selfplay.txt --eps 0.0 --gamma 0.95 --lr 0.5 --momentum 0.1 --nepoch 4 --nesterov --ref_text data/final_casino_dndformat/train.txt --rl_clip 1 --rl_lr 0.2 --score_threshold 6 --sv_train_freq 4 --temperature 0.5 --alice_model ../logs/casino_dndformat_supervised_30ep.pt --bob_model ../logs/casino_dndformat_supervised_30ep.pt --rw_type combine50_50 --output_model_file ../logs/casino_dndform_rl_fair_4ep.pt