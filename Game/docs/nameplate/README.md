# Nameplate

Nameplate is an [Ashita v4](https://github.com/AshitaXI/Ashita-v4beta) plugin that corrects XI's nameplate aspect ratio.

## Installation

If you're already using Ashita v4, you likely already know how to do this.

Make sure the plugin api version matches the Ashita 4 api version.
This version of Nameplate requires ***Ashita 4 interface 4.15***.

## Usage

`/load Nameplate` to load the plugin.  `/nameplate help` to read the
in-game command help.

The font size can be configured via the `FontSizeInPx` setting in
`config\nameplate\defaults.ini`.

Job Mastery stars can be hidden by setting `HideStars=1` in the configuration.

Nameplate visibility modes can be changed via the `NameMode` setting.

| command                        | description                                                                        |
|--------------------------------|------------------------------------------------------------------------------------|
| /nameplate help                | You're reading it!                                                                 |
| /nameplate load                | Load configuration from `config\nameplate\defaults.ini`                            |
| /nameplate save                | Save current configuration to `config\nameplate\defaults.ini`                      |
| /nameplate fontsize `<number>` | Set the nameplate font size to `<number>` pixels                                   |
| /nameplate hidestars           | Hide all Job Mastery stars                                                         |
| /nameplate showstars           | Re-enable displaying Job Mastery stars                                             |
| /nameplate mode all            | Show all nameplates                                                                |
| /nameplate mode none           | Hide all nameplates                                                                |
| /nameplate mode hideself       | Hide your own nameplate                                                            |
| /nameplate mode hidepc         | Hide all player nameplates, except when charmed                                    |
| /nameplate mode hidepcself     | Hide all player nameplates, except when charmed, but also always keep yours hidden |
| /nameplate mode hidenpc        | Hide all non-player nameplates                                                     |
| /nameplate mode hidenpcself    | Hide all non-player nameplates, but also always keep yours hidden                  |

## For More Information

https://ffxi.somepage.org/

## Legal

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
