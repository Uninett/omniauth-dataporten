require 'spec_helper'

describe OmniAuth::Strategies::Dataporten do

  let(:access_token) { double('AccessToken') }
  let(:parsed_response) { double('ParsedResponse') }
  let(:response) { double('Response', parsed: parsed_response) }

  let(:site)           { 'https://auth.dataporten.no' }
  let(:authorization_url)  { '/oauth/authorization' }
  let(:token_url)      { '/oauth/access_token' }

  let(:dataporten_service) { OmniAuth::Strategies::Dataporten.new({}) }
  let(:enterprise) do
    OmniAuth::Strategies::Dataporten.new('DATAPORTEN_KEY', 'DATAPORTEN_SECRET',
                                         client_options: {
                                             site: site,
                                             authorize_url: authorization_url,
                                             token_url: token_url
                                         },
                                         redirect_url: 'http://localhost:9292/callback_url'
    )
  end

  subject { dataporten_service }

  before(:each) do
    allow(subject).to receive(:access_token).and_return(access_token)
  end

  describe 'client options' do
    context 'with defaults' do
      subject { dataporten_service.options.client_options }

      its(:site) { is_expected.to eq 'https://auth.dataporten.no' }
      its(:authorize_url) { is_expected.to eq '/oauth/authorization' }
      its(:token_url) { is_expected.to eq '/oauth/token' }
    end

    context 'with override' do
      subject { enterprise.options.client_options }

      its(:site) { is_expected.to eq site }
      its(:authorize_url) { is_expected.to eq authorization_url }
      its(:token_url) { is_expected.to eq token_url }
    end
  end

  describe 'redirect_url' do
    context 'with defaults' do
      subject { dataporten_service.options }
      its(:redirect_url) { is_expected.to be_nil }
    end

    context 'with customs' do
      subject { enterprise.options }
      its(:redirect_url) { is_expected.to eq 'http://localhost:9292/callback_url' }
    end
  end

  describe '#raw_info' do
    it 'sent request to current user endpoint' do
      expect(access_token).to receive(:get).with('/userinfo').and_return(response)
      expect(subject.raw_info).to eq(parsed_response)
    end
  end
end