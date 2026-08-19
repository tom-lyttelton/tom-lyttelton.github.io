# thomaslyttelton.com

Static personal site — landing page plus CV. No build step, no dependencies, no
framework. Plain HTML and CSS served by GitHub Pages.

## Files

| Path              | Purpose                                              |
| ----------------- | ---------------------------------------------------- |
| `index.html`      | Landing page: photo, position, research focus         |
| `research.html`   | Papers, grouped by status, with links                 |
| `styles.css`      | All styling, light and dark theme                     |
| `assets/CV.pdf`   | Generated — do not edit by hand (see below)           |
| `assets/headshot.jpg` | Portrait, 900px wide                              |
| `build-cv.sh`     | Regenerates `assets/CV.pdf` from the LaTeX source     |
| `CNAME`           | Custom domain GitHub Pages serves the site at         |
| `.nojekyll`       | Tells GitHub Pages to serve files as-is               |

The nav's "CV" link points straight at `assets/CV.pdf` — there is no HTML CV page.

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

**`research.html` is maintained separately and does not update itself.** When a
paper is published or changes status, edit `research.html` to match. The PDF is
authoritative if the two ever disagree.

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

The site is served at <https://thomaslyttelton.com>. The `CNAME` file in this
repo is what tells GitHub Pages that; do not delete or rename it. Requests to
`tom-lyttelton.github.io` redirect to the custom domain automatically.

The domain is registered with Cloudflare, which is also the authoritative DNS
host, so the records live in the Cloudflare dashboard, not here:

| Type  | Host  | Value                                                       |
| ----- | ----- | ----------------------------------------------------------- |
| A     | `@`   | `185.199.108.153` `185.199.109.153` `185.199.110.153` `185.199.111.153` |
| AAAA  | `@`   | `2606:50c0:8000::153` `2606:50c0:8001::153` `2606:50c0:8002::153` `2606:50c0:8003::153` |
| CNAME | `www` | `tom-lyttelton.github.io`                                   |

Every record must be **DNS only** (grey cloud, not orange). Proxying through
Cloudflare stops GitHub from issuing the TLS certificate.

After DNS propagates, enable **Enforce HTTPS** in the repo's
Settings → Pages. The certificate is issued by GitHub and can take up to
24 hours to appear.

To verify:

```sh
dig +short thomaslyttelton.com
curl -sI https://thomaslyttelton.com | head -1
```

The site previously used `thomaslyttelton.org`, registered through Wix. Wix does
not allow delegating a domain it registered to external nameservers, which made
it unusable with GitHub Pages. That domain was abandoned rather than transferred.
