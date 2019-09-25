import { Elm } from './src/Main.elm';
import click1 from './src/click1.wav';
import click2 from './src/click2.wav';

Elm.Main.init({
  node: document.getElementById('root'),
  flags: {
    click1,
    click2
  }
});
