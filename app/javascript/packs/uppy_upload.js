import Rails from "@rails/ujs";

const Uppy = require('@uppy/core')
const Dashboard = require('@uppy/dashboard')
const ActiveStorageUpload = require('@excid3/uppy-activestorage-upload')

const GoogleDrive = require('@uppy/google-drive')
const Dropbox = require('@uppy/dropbox')
const OneDrive = require('@uppy/onedrive')
const Webcam = require('@uppy/webcam')


require('@uppy/core/dist/style.css')
require('@uppy/dashboard/dist/style.css')

const element = document.querySelector('[data-uppy]')
setupUppy(element)

function setupUppy(element) {
    let trigger = element.querySelector('[data-behavior="uppy-trigger"]')
    let direct_upload_url = document.querySelector("meta[name='direct-upload-url']").getAttribute("content")
    let field_name = element.dataset.uppy

    trigger.onclick = (event) => event.preventDefault()

    const uppy = new Uppy({
        autoProceed: false,
        allowMultipleUploads: false,
        logger: Uppy.debugLogger,
        restrictions: {
            maxFileSize: 100000000,
            maxNumberOfFiles: 1,
            minNumberOfFiles: 1,
            allowedFileTypes: ['video/*']
        }
    })

    uppy.use(Dashboard, {
        trigger: trigger,
        closeAfterFinish: false,
        showProgressDetails: true,
        height: 470,
        browserBackButtonClose: false,
        proudlyDisplayPoweredByUppy: false
    })


    uppy
        .use(ActiveStorageUpload, {
            directUploadUrl: direct_upload_url
        })
        .use(GoogleDrive, {target: Dashboard, companionUrl: 'https://companion.uppy.io'})
        .use(Dropbox, {target: Dashboard, companionUrl: 'https://companion.uppy.io'})
        .use(OneDrive, {target: Dashboard, companionUrl: 'https://companion.uppy.io'})
        .use(Webcam, {
            target: Dashboard,
            onBeforeSnapshot: () => Promise.resolve(),
            countdown: false,
            modes: [
                'video-audio',
                'video-only',
            ],
            mirror: false,
            videoConstraints: {
                facingMode: 'user',
                // width: {min: 720, ideal: 1280, max: 1920},
                // height: {min: 480, ideal: 800, max: 1080},
                width: {ideal: 300},
                height: {ideal: 300}
            },
            showRecordingLength: false,
            preferredVideoMimeType: "mp4",
            preferredImageMimeType: null,
        })


    uppy.on('complete', (result) => {
        result.successful.forEach(file => {
            appendUploadedFile(element, file, field_name)
        })

        if (result.failed.length === 0) {
            const form = document.getElementById('testimonial-video-form')
            Rails.fire(form, 'submit')
        }

    })
}

function appendUploadedFile(element, file, field_name) {
    const hiddenField = document.createElement('input')

    hiddenField.setAttribute('type', 'hidden')
    hiddenField.setAttribute('name', field_name)
    hiddenField.setAttribute('data-pending-upload', true)
    hiddenField.setAttribute('value', file.response.signed_id)

    element.appendChild(hiddenField)
}
