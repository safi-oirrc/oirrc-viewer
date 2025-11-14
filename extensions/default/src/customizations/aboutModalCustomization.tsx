import React from 'react';
import { AboutModal } from '@ohif/ui-next';

function AboutModalDefault() {
  return (
    <AboutModal className="w-[400px]">
      <AboutModal.ProductName>OIRRC Viewer</AboutModal.ProductName>
      <AboutModal.Body>
        <div className="text-muted-foreground px-6 py-4 text-center text-sm">
          A web-based medical imaging viewer for viewing and analyzing DICOM images and studies.
        </div>
      </AboutModal.Body>
    </AboutModal>
  );
}

export default {
  'ohif.aboutModal': AboutModalDefault,
};
