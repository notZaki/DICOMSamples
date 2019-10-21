module DICOMSamples

const download_folder = joinpath(@__DIR__, "DICOMSamples")
const temp_folder_for_gz = joinpath(@__DIR__, "gz")
const temp_folder_for_zip = joinpath(@__DIR__, "zip")

const files_to_download = Dict(
    "CT_Explicit_Little.dcm" => "https://dl.dropboxusercontent.com/s/u2rj556q3xcgv2b/CT-MONO2-16-brain.gz",
    "CT_Implicit_Little_Headless_Retired.dcm" => "https://dl.dropboxusercontent.com/s/0lcawkys1c9mjwl/CT-MONO2-12-lomb-an2.gz",
    "MR_Explicit_Little_MultiFrame.dcm" => "https://dl.dropboxusercontent.com/s/8p3bpjvhnz2avzw/MR-MONO2-8-16x-heart.gz",
    "MR_Implicit_Little.dcm" => "https://dl.dropboxusercontent.com/s/2wdpdwbv3vs5glf/MR-MONO2-16-head.gz",
    "MR_UnspecifiedLength.dcm" => "https://drive.google.com/uc?export=download&id=1lm0750H-1O22O7Bqy0yfq0FK_vDrqC7-",
    "OT_Implicit_Little_Headless.dcm" => "https://dl.dropboxusercontent.com/s/xlxfqfu974if96l/OT-MONO2-8-a7.gz",
    "US_Explicit_Big_RGB.dcm" => "https://dl.dropboxusercontent.com/s/y2l1myu5uw6bzlg/US-RGB-8-epicard.gz"
)

# [!] This function relies on the global variable `files_to_download`
function download_dicom_samples()
    create_folder(download_folder)
    create_folder(temp_folder_for_gz, clean=true)
    for (filename, url) in files_to_download
        curfile = is_gz(url) ? download_gz(filename, url) : download_dicom(filename, url)
        println(`Downloaded: $(curfile)`)
    end
    delete_folder(temp_folder_for_gz)
    download_special_case_1()
    return
end

function create_folder(path; clean = false)
    if !isdir(path)
        mkdir(path)
    elseif clean
        delete_folder(path)
        create_folder(path)
    end
    return
end

function delete_folder(path; recursive=true)
    if isdir(path)
        rm(path, recursive=recursive)
    end
    return
end

is_gz(path) = splitext(path)[2] == ".gz"

function download_gz(filename, url)
    filename_gz = splitext(filename)[1] * ".gz"
    downloaded_gz = joinpath(temp_folder_for_gz, filename_gz)
    download(url, downloaded_gz)
    run(`gzip -d $(downloaded_gz)`)
    unzipped_dicom = find_dicom_file(downloaded_gz)
    downloaded_dicom = joinpath(download_folder, filename)
    mv(unzipped_dicom, downloaded_dicom, force=true)
    return downloaded_dicom
end

function find_dicom_file(file_gz)
    candidates = [
        change_ext(file_gz, ".dcm"),
        change_ext(file_gz, "")
    ]
    found_index = findfirst(isfile.(candidates))
    if isempty(found_index)
        error(`Unzipped DICOM file not found for $(file_gz)`)
    end
    return candidates[found_index]
end

change_ext(path, ext) = splitext(path)[1] * ext

function download_dicom(filename, url)
    downloaded_dicom = joinpath(download_folder, filename)
    download(url, downloaded_dicom)
    return downloaded_dicom
end

function download_special_case_1()
    create_folder(temp_folder_for_zip, clean=true)
    fileMG_zip = joinpath(temp_folder_for_zip, "MG_Explicit_Little.zip")
    download("http://www.dclunie.com/images/pixelspacingtestimages.zip", fileMG_zip)
    run(`unzip -o $fileMG_zip -d $temp_folder_for_zip`)
    unzipped_file = joinpath(temp_folder_for_zip, "DISCIMG", "IMAGES", "MGIMAGEA")
    downloaded_dicom = joinpath(download_folder, "MG_Explicit_Little.dcm")
    mv(unzipped_file, downloaded_dicom, force=true)
    delete_folder(temp_folder_for_zip)
    println(`Downloaded: $(downloaded_dicom)`)
    return
end

export download_dicom_samples

end
