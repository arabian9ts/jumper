import numpy as np

from config.configure import Configure

conf = Configure()

#== universal
conf.sampling_rate = 44100
conf.duration = 1
conf.hop_length = 347
conf.fmin = 20
conf.fmax = conf.sampling_rate // 2
conf.n_mels = 128
conf.n_fft = conf.n_mels * 20
conf.samples = conf.sampling_rate * conf.duration
conf.num_classes = 7

#== for recognizer
conf.rt_process_count = 1
conf.rt_oversamples = 10

#== for trainer
conf.batch_size = 32
conf.learning_rate = 0.0001
conf.epochs = 60
conf.verbose = 2
conf.dims = (conf.n_mels, 1 + int(np.floor(conf.samples/conf.hop_length)), 1)
conf.rt_chunk_samples = conf.sampling_rate // conf.rt_oversamples
conf.mels_onestep_samples = conf.rt_chunk_samples * conf.rt_process_count
conf.mels_convert_samples = conf.samples + conf.mels_onestep_samples
conf.labels = ['noise', 'finger', 'bell', 'gong', 'scissors', 'knock', 'laughter']
