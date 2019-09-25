import { Elm } from './src/Main.elm';
import click1 from './src/click1.wav';
import click2 from './src/click2.wav';

const app = Elm.Main.init({
  node: document.getElementById('root'),
  flags: {
    click1,
    click2
  }
});

const [firstAudio, secondAudio] = document.querySelectorAll('audio');

app.ports.tick.subscribe((timesTicked) => {
  if (timesTicked % 4 === 0) {
    secondAudio.play();
  } else {
    firstAudio.play();
  }
});
