<img src="github/Jumper.png" width=80% />

# This is VR tripping App
(This App was developed at the Hackathon.)  
We can trip around the world with finger-snapping.  
First, you choose world playlist, then there is VR-360 angle world.

### Playlist view
<img src="github/Playlist.png" width=50% />

### VR-360 World
<img src="github/VR-360.png" width=50% />

# Usage

### API
```shell
$ cd api/jumper
$ pip install -r requirements.txt
$ python server.py
```

### App
```shell
$ cd app
$ bundle exec pod install
```

### Notice
- The API endpoint is hard-coded in https://github.com/arabian9ts/jumper/blob/dev/app/jumper/APIs/PredictionAPI.swift#L21 (please fix this line).
- VR-360 World movie file was unset. Please prepare movie in your-self and set url in https://github.com/arabian9ts/jumper/blob/dev/app/jumper/Utils/PlaylistMock.swift .
