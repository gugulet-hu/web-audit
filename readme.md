# Web Audit
[![License: MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)

<img src="https://github.com/gugulet-hu/web-audit/blob/master/website-icon-512x512.png" alt="Web Audit logo" width="50" />

An applet to run lightouse reports, page speed tests and screenshots of the webistes I manage. Uses theses great NPM packages: [site-audit-seo](https://github.com/viasite/site-audit-seo) and [capture-website-cli](https://github.com/sindresorhus/capture-website-cli), which both in turn use [Puppeteer](https://github.com/puppeteer/puppeteer). Next step is to remove all the hardcoded values and ask for user input for the the sites to scan.

## Dependencies

```bash
npm i site-audit-seo capture-website-cli
```

## License

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.