require 'rails_helper'

RSpec.describe Photograph, :type => :model do
  context 'Photograph Class' do
    subject { Photograph.new }

    it { is_expected.to have_metadata_stream_of_type(PhotographMetadata) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::GeographicDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::PhysicalDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::NotationsDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::DigitalDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::CreationDatastream) }

    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:downloadable) }
    it { is_expected.to respond_to(:downloadable_ocr) }
  end
end
