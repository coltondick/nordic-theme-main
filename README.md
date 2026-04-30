<!-- PROJECT SHIELDS -->
<div align="center">

[![hacs_badge](https://img.shields.io/badge/HACS-Default-41BDF5.svg?style=for-the-badge)](https://github.com/hacs/integration) [![Last Commit](https://img.shields.io/github/last-commit/coltondick/nordic-theme-main?style=for-the-badge)](https://github.com/coltondick/nordic-theme-main/commits/main) [![GitHub license](https://img.shields.io/github/license/coltondick/nordic-theme-main?style=for-the-badge)](https://github.com/coltondick/nordic-theme-main/blob/main/LICENSE)

</div>

<div align="center">

  <h1 align="center">Home Assistant Nordic Theme</h1>

  <p align="center">
     A simple Nordic theme based on the <a href="https://www.nordtheme.com/docs/colors-and-palettes">Nord color palette</a>.
    <br />
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#screenshots">Screenshots</a></li>
    <li><a href="#home-assistant-setup">Home Assistant Setup</a></li>
    <li><a href="#hacs-installation">HACS installation</a></li>
    <li><a href="#enable-theme">Enable theme</a></li>
    <li><a href="#color-options">Color Options</a></li>
    <li><a href="#color-reference">Color Reference</a></li>
  </ol>
</details>

## Screenshots

### Nordic Light

<table>
  <tr>
    <td align="center" width="50%"><strong>Demo</strong><br /><img src="images/nordic-light/nordic-light-demo.png" alt="Nordic Light Demo" width="620" /></td>
    <td align="center" width="50%"><strong>Dialogs</strong><br /><img src="images/nordic-light/nordic-light-dialogs.png" alt="Nordic Light Dialogs" width="620" /></td>
  </tr>
  <tr>
    <td align="center" width="50%"><strong>Metrics</strong><br /><img src="images/nordic-light/nordic-light-metrics.png" alt="Nordic Light Metrics" width="620" /></td>
    <td align="center" width="50%"><strong>Rodents</strong><br /><img src="images/nordic-light/nordic-light-rodents.png" alt="Nordic Light Rodents" width="620" /></td>
  </tr>
  <tr>
    <td align="center" width="50%"><strong>Thermostat</strong><br /><img src="images/nordic-light/nordic-light-thermostat.png" alt="Nordic Light Thermostat" width="620" /></td>
    <td align="center" width="50%"></td>
  </tr>
</table>

### Nordic Dark

<table>
  <tr>
    <td align="center" width="50%"><strong>Demo</strong><br /><img src="images/nordic-dark/nordic-dark-demo.png" alt="Nordic Dark Demo" width="620" /></td>
    <td align="center" width="50%"><strong>Dialogs</strong><br /><img src="images/nordic-dark/nordic-dark-dialogs.png" alt="Nordic Dark Dialogs" width="620" /></td>
  </tr>
  <tr>
    <td align="center" width="50%"><strong>Metrics</strong><br /><img src="images/nordic-dark/nordic-dark-metrics.png" alt="Nordic Dark Metrics" width="620" /></td>
    <td align="center" width="50%"><strong>Rodents</strong><br /><img src="images/nordic-dark/nordic-dark-rodents.png" alt="Nordic Dark Rodents" width="620" /></td>
  </tr>
  <tr>
    <td align="center" width="50%"><strong>Thermostat</strong><br /><img src="images/nordic-dark/nordic-dark-thermostat.png" alt="Nordic Dark Thermostat" width="620" /></td>
    <td align="center" width="50%"></td>
  </tr>
</table>

### Nordic Blue Light

<table>
  <tr>
    <td align="center" width="50%"><strong>Demo</strong><br /><img src="images/nordic-blue-light/nordic-blue-light-demo.png" alt="Nordic Blue Light Demo" width="620" /></td>
    <td align="center" width="50%"><strong>Dialogs</strong><br /><img src="images/nordic-blue-light/nordic-blue-light-dialogs.png" alt="Nordic Blue Light Dialogs" width="620" /></td>
  </tr>
  <tr>
    <td align="center" width="50%"><strong>Metrics</strong><br /><img src="images/nordic-blue-light/nordic-blue-light-metrics.png" alt="Nordic Blue Light Metrics" width="620" /></td>
    <td align="center" width="50%"><strong>Rodents</strong><br /><img src="images/nordic-blue-light/nordic-blue-light-rodents.png" alt="Nordic Blue Light Rodents" width="620" /></td>
  </tr>
  <tr>
    <td align="center" width="50%"><strong>Thermostat</strong><br /><img src="images/nordic-blue-light/nordic-blue-light-thermostat.png" alt="Nordic Blue Light Thermostat" width="620" /></td>
    <td align="center" width="50%"></td>
  </tr>
</table>

### Nordic Blue Dark

<table>
  <tr>
    <td align="center" width="50%"><strong>Demo</strong><br /><img src="images/nordic-blue-dark/nordic-blue-dark-demo.png" alt="Nordic Blue Dark Demo" width="620" /></td>
    <td align="center" width="50%"><strong>Dialogs</strong><br /><img src="images/nordic-blue-dark/nordic-blue-dark-dialogs.png" alt="Nordic Blue Dark Dialogs" width="620" /></td>
  </tr>
  <tr>
    <td align="center" width="50%"><strong>Metrics</strong><br /><img src="images/nordic-blue-dark/nordic-blue-dark-metrics.png" alt="Nordic Blue Dark Metrics" width="620" /></td>
    <td align="center" width="50%"><strong>Rodents</strong><br /><img src="images/nordic-blue-dark/nordic-blue-dark-rodents.png" alt="Nordic Blue Dark Rodents" width="620" /></td>
  </tr>
  <tr>
    <td align="center" width="50%"><strong>Thermostat</strong><br /><img src="images/nordic-blue-dark/nordic-blue-dark-thermostat.png" alt="Nordic Blue Dark Thermostat" width="620" /></td>
    <td align="center" width="50%"></td>
  </tr>
</table>

### Home Assistant Setup

Make sure that under the **configuration.yaml** file you have the following:

```yaml
frontend:
  themes: !include_dir_merge_named themes
```

### HACS installation

1. Go into the Community Store (HACS)
2. Search for Nordic theme
3. Open the theme
4. Press Install
5. (optional) Restart Home Assistant

### Enable theme

1. Open your Home Assistant **Profile**
2. Under **Themes**, select the new Nordic theme

### Color Options

Any of the colors can be used anywhere a color parameter is accepted in Home Assistant's configuration.

```yaml
## Example graph card using color from the theme variables.

type: custom:mini-graph-card
entities:
  - sensor.temperature
name: Weather
line_color: var(--aurora-red) # Replace var(--aurora-red) with any of the color variables listed below. ex. var(--snow-dark)
line_width: 8
font_size: 100
hours_to_show: 168
points_per_hour: 0.25
```

### Color Reference

| Color Variable    | Color Code | Color                                          |
| ----------------- | ---------- | ---------------------------------------------- |
| aurora-red        | #bf616a    | ![](https://readme-swatches.vercel.app/bf616a) |
| aurora-blue       | #5e81ac    | ![](https://readme-swatches.vercel.app/5e81ac) |
| aurora-green      | #a3be8c    | ![](https://readme-swatches.vercel.app/a3be8c) |
| aurora-yellow     | #ebcb8b    | ![](https://readme-swatches.vercel.app/ebcb8b) |
| aurora-orange     | #d08770    | ![](https://readme-swatches.vercel.app/d08770) |
| aurora-pink       | #b48ead    | ![](https://readme-swatches.vercel.app/b48ead) |
| frost-green       | #8fbcbb    | ![](https://readme-swatches.vercel.app/8fbcbb) |
| frost-sky-blue    | #88c0d0    | ![](https://readme-swatches.vercel.app/88c0d0) |
| frost-cadet-blue  | #81a1c1    | ![](https://readme-swatches.vercel.app/81a1c1) |
| frost-steel-blue  | #5e81ac    | ![](https://readme-swatches.vercel.app/5e81ac) |
| snow-dark         | #d8dee9    | ![](https://readme-swatches.vercel.app/d8dee9) |
| snow-medium       | #e5e9f0    | ![](https://readme-swatches.vercel.app/e5e9f0) |
| snow-light        | #eceff4    | ![](https://readme-swatches.vercel.app/eceff4) |
| polar-dark-gray   | #2e3440    | ![](https://readme-swatches.vercel.app/2e3440) |
| polar-bright-gray | #3B4252    | ![](https://readme-swatches.vercel.app/3B4252) |
| polar-river-gray  | #434c5e    | ![](https://readme-swatches.vercel.app/434c5e) |
| polar-light-gray  | #4c566a    | ![](https://readme-swatches.vercel.app/4c566a) |
