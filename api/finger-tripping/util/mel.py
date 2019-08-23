import numpy as np
import librosa


def load_wave(conf, path):
    data = librosa.load(path, sr=conf.sampling_rate)
    cut_sound = np.asarray(data[0][:conf.sampling_rate * conf.duration])
    if len(cut_sound) == conf.samples * conf.duration:
        return cut_sound
    else:
        return None

def load_wavs(conf, pathsets):
    wavs = []
    loaded_paths, loaded_labels = [], []
    for pathset in pathsets:
        wav = load_wave(conf, pathset[0])
        if wav is not None:
          wavs.append(wav)
          loaded_paths.append(pathset[0])
          loaded_labels.append(pathset[1])
    return wavs, loaded_paths, loaded_labels

def sound_to_mel(conf, array):
    melspectrogram = librosa.feature.melspectrogram(array,
                                                 sr=conf.sampling_rate,
                                                 n_mels=conf.n_mels,
                                                 hop_length=conf.hop_length,
                                                 n_fft=conf.n_fft,
                                                 fmin=conf.fmin,
                                                 fmax=conf.fmax)
    melspectrogram = librosa.power_to_db(melspectrogram)
    melspectrogram = melspectrogram.astype(np.float32)

    if melspectrogram.shape == (128, 128):
        return np.reshape(melspectrogram, (128, 128, 1))

    return None

def sounds_to_mels(conf, sound_array):
    mels = []
    for sound in sound_array:
        mel = sound_to_mel(conf, sound)
        if mel is not None:
            mels.append(mel)
    return mels
