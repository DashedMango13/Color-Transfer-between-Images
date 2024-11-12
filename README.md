# Color Transfer Between Images

This MATLAB script performs color transfer between two images. Given two images, \$A\$ (source) and \$B\$ (target), this script outputs a new image with the color characteristics of \$B\$ applied to A.

Supports .JPEG, .PNG, .TIFF, etc.

Based on Reinhard, Erik & Ashikhmin, Michael & Gooch, Bruce & Shirley, Peter. (2001). Color Transfer between Images. IEEE Computer Graphics and Applications. 21. 34-41. 10.1109/38.946629. 

# Examples

Below are examples demonstrating the input images and the resulting output.

## Example 1

<p align="center">
  <table>
    <tr>
      <th>Input Image A (Source)</th>
      <th>Input Image B (Target)</th>
      <th>Output Image</th>
    </tr>
    <tr>
      <td><img src="./READMEAssets/harbor.png" height="250"></td>
      <td><img src="./READMEAssets/palm.png" height="250"></td>
      <td><img src="./READMEAssets/PalmHarbor.png" height="250"></td>
    </tr>
  </table>
</p>

## Example 2

<p align="center">
  <table>
    <tr>
      <th>Input Image A (Source)</th>
      <th>Input Image B (Target)</th>
      <th>Output Image</th>
    </tr>
    <tr>
      <td><img src="./READMEAssets/sunset-1.png" height="250"></td>
      <td><img src="./READMEAssets/temple.png" height="250"></td>
      <td><img src="./READMEAssets/TempleSunset.png" height="250"></td>
    </tr>
  </table>
</p>


## Example 3

<p align="center">
  <table>
    <tr>
      <th>Input Image A (Source)</th>
      <th>Input Image B (Target)</th>
      <th>Output Image</th>
    </tr>
    <tr>
      <td><img src="./READMEAssets/plain.png" height="250"></td>
      <td><img src="./READMEAssets/snowfall-1.png" height="250"></td>
      <td><img src="./READMEAssets/SnowfallPlain.png" height="250"></td>
    </tr>
  </table>
</p>

## Example 4

<p align="center">
  <table>
    <tr>
      <th>Input Image A (Source)</th>
      <th>Input Image B (Target)</th>
      <th>Output Image</th>
    </tr>
    <tr>
      <td><img src="./READMEAssets/temple.png" height="250"></td>
      <td><img src="./READMEAssets/plain.png" height="250"></td>
      <td><img src="./READMEAssets/PlainTemple.png" height="250"></td>
    </tr>
  </table>
</p>

## Usage

1. Clone the repository
2. Open "ColorTransfer.m" in MATLAB
3. Edit src and target file path strings to input images:
   ```bash
   src = imread("imageA.tif");   %Input Image
   tgt = imread("imageB.png");   %Desired Color
4. Run the script and the result will be outputted to ""
