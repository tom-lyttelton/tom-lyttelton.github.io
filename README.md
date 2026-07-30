# thomaslyttelton.org

Static personal site — landing page plus CV. No build step, no dependencies, no
framework. Plain HTML and CSS served by GitHub Pages.

## Files

| Path              | Purpose                                              |
| ----------------- | ---------------------------------------------------- |
| `index.html`      | Landing page: photo, position, research focus         |
| `cv.html`         | CV as a web page                                      |
| `styles.css`      | All styling, light and dark theme                     |
| `assets/CV.pdf`   | Generated — do not edit by hand (see below)           |
| `assets/headshot.jpg` | Portrait, 900px wide                              |
| `build-cv.sh`     | Regenerates `assets/CV.pdf` from the LaTeX source     |
| `.nojekyll`       | Tells GitHub Pages to serve files as-is               |

## Updating the CV

The LaTeX file is the single source of truth:

```
~/Library/CloudStorage/Dropbox-Personal/Apps/Overleaf/job market/CV.tex
```

After editing it (in Overleaf or locally), regenerate the PDF and publish:

```sh
./build-cv.sh
git commit -am "update CV"
git push
```

`build-cv.sh` compiles with [Tectonic](https://tectonic-typesetting.github.io/)
at `~/.local/bin/tectonic`. It writes only `assets/CV.pdf`.

**`cv.html` is maintained separately and does not update itself.** When the
`.tex` changes substantively — a new publication, a job change — edit `cv.html`
to match. The PDF is authoritative if the two ever disagree.

## Local preview

```sh
open index.html
```

Or, closer to how GitHub Pages serves it:

```sh
python3 -m http.server 8000
```

then visit <http://localhost:8000>.

## Custom domain

`thomaslyttelton.org` is registered through Wix (backend registrar Tucows) and
is transfer-locked until **13 August 2026** following a registrar transfer on
14 June 2026. After that date it can be moved to another registrar and pointed
here. To attach it, add a `CNAME` file containing `thomaslyttelton.org` and set
the DNS records GitHub Pages specifies.
