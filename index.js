import { Howl } from 'howler';
import { Elm } from './src/Main.elm';

// Click 1 audio files
import click1Wav from './src/click1.wav';
import click1Mp3 from './src/click1.mp3';
import click1Ogg from './src/click1.ogg';

// Click 2 audio files
import click2Wav from './src/click2.wav';
import click2Mp3 from './src/click2.mp3';
import click2Ogg from './src/click2.ogg';

const app = Elm.Main.init({
  node: document.getElementById('root')
});

const firstAudio = new Howl({
  src: [click1Mp3, click1Wav, click1Ogg]
});

const secondAudio = new Howl({
  src: [click2Mp3, click2Wav, click2Ogg]
});

app.ports.tick.subscribe((timesTicked) => {
  if (timesTicked % 4 === 0) {
    secondAudio.play();
  } else {
    firstAudio.play();
  }
});
