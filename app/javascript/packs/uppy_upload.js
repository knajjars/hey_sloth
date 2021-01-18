import Rails from "@rails/ujs";

import Uppy from "@uppy/core";
import Dashboard from "@uppy/dashboard";
import ActiveStorageUpload from "@excid3/uppy-activestorage-upload";

import "@uppy/core/dist/style.css";
import "@uppy/dashboard/dist/style.css";
import "@uppy/webcam/dist/style.css";

const Webcam = require("@uppy/webcam");

const element = document.querySelector("[data-uppy]");
setupUppy(element);

function setupUppy(element) {
  let trigger = element.querySelector('[data-behavior="uppy-trigger"]');
  let direct_upload_url = document
    .querySelector("meta[name='direct-upload-url']")
    .getAttribute("content");
  let field_name = element.dataset.uppy;

  trigger.onclick = (event) => event.preventDefault();

  const uppy = new Uppy({
    onBeforeFileAdded: (file, files) => {
      // Rails has an issue with file type "video/webm;codecs=vp8,opus"
      if (file.data.type === "video/webm;codecs=vp8,opus") {
        return {
          ...file,
          data: file.data.slice(0, file.data.size, "video/webm"),
        };
      }
      return file;
    },
    autoProceed: false,
    allowMultipleUploads: false,
    logger: Uppy.debugLogger,
    restrictions: {
      maxFileSize: 100000000,
      maxNumberOfFiles: 1,
      minNumberOfFiles: 1,
      allowedFileTypes: ["video/*"],
    },
  })
    .use(ActiveStorageUpload, {
      directUploadUrl: direct_upload_url,
    })
    .use(Dashboard, {
      trigger: trigger,
      closeAfterFinish: false,
      showProgressDetails: true,
      height: 470,
      browserBackButtonClose: false,
      proudlyDisplayPoweredByUppy: false,
    })
    .use(Webcam, {
      target: Dashboard,
      countdown: false,
      modes: ["video-audio"],
      mirror: false,
      videoConstraints: {
        facingMode: "user",
        width: { ideal: 300 },
        height: { ideal: 300 },
      },
      showRecordingLength: true,
    });

  uppy.on("complete", (result) => {
    result.successful.forEach((file) => {
      appendUploadedFile(element, file, field_name);
    });

    if (result.failed.length === 0) {
      const form = document.getElementById("testimonial-video-form");
      Rails.fire(form, "submit");
    }
  });
}

function appendUploadedFile(element, file, field_name) {
  const hiddenField = document.createElement("input");

  hiddenField.setAttribute("type", "hidden");
  hiddenField.setAttribute("name", field_name);
  hiddenField.setAttribute("data-pending-upload", true);
  hiddenField.setAttribute("value", file.response.signed_id);

  element.appendChild(hiddenField);
}
