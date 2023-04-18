# DICOM Samples

This repository contains some DICOM samples which were used to test the [DICOM.jl](https://github.com/JuliaIO/DICOM.jl) package.  
The file were downloaded from different locations using the script `download_dicom_samples.jl`.

## Files & Descriptions

- `CT_Explicit_Little.dcm`
  + Computed tomography image under the name of `CT-MONO2-16-brain` downloaded from [Barre's Collection][barre]
  + Tests if the code can handle signed data, i.e. `(0028,0103) Pixel Representation = 1`
- `CT_JPEG70.dcm`
  + Computed tomography image under the name of `CT-MONO2-16-chest` downloaded from [Barre's Collection][barre]
  + Tests if JPEG compressed image can be parsed
- `CT_Implicit_Little_Headless_Retired.dcm`
  + Computed tomography image under the name of `CT-MONO2-12-lomb-an2` downloaded from [Barre's Collection][barre]
  + Tests if the code can handle retired dicom tags which might not exist in the dictionary
  + The file is also missing the 128-byte preamble which is why it is "headless"
- `MG_Explicit_Little.dcm`
  + A pixel callibration profile downloaded from [David Clunie's website](http://www.dclunie.com/)
  + This was the first test case for the DICOM.jl package
- `MR_Explicit_Little_MultiFrame.dcm`
  + Magnetic resonance image under the name of `MR-MONO2-8-16x-heart` downloaded from [Barre's Collection][barre]
  + Tests if code can handle a multiple frames within a single DICOM file
- `MR_Implicit_Little.dcm`
  + Magnetic resonance image under the name of `MR-MONO2-16-head` downloaded from [Barre's Collection][barre]
  + Tests if code can read a basic/simple DICOM image
- `MR_UnspecifiedLength.dcm`
  + A single mask from the [ISPY1 collection on the cancer imaging archive][ispy-collection], under the CC-By-3.0 licence
  + This file was added to test if the code can handle elements with undefined length
- `OT_Implicit_Little_Headless`
  + Image under the name of `OT-MONO2-8-a7` downloaded from [Barre's Collection][barre]
  + Tests if code can handle files which lack the 128-byte preamble	
- `US_Explicit_Big_RGB.dcm`
  + Image under the name of `US-RGB-8-epicard` downloaded from [Barra's Collection][barre]
  + Tests if code can handle big-endian file
  + The dicom image is 640x480, unlike most other dicom files where the number of columns and rows is identical. This is useful for testing if the data is being read in the right order.
- `DX_Implicit_Little_Interleaved`:
  + Obtained from [OHIF-Viewer's test data][https://github.com/OHIF/viewer-testdata/raw/master/dcm/zoo-exotic/5.dcm]

[barre]: https://barre.dev/medical/samples/
[ispy-collection]: https://wiki.cancerimagingarchive.net/display/Public/ISPY1
