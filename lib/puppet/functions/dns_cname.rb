# frozen_string_literal: true

# Retrieves a DNS CNAME record and returns it as a string.
#
# An optional lambda can be given to return a default value in case the
# lookup fails. The lambda will only be called if the lookup failed.
Puppet::Functions.create_function(:dns_cname) do
  dispatch :dns_cname do
    param 'String', :record
  end

  dispatch :dns_cname_with_default do
    param 'String', :record
    block_param
  end

  def dns_cname(record)
    Puppet.deprecation_warning('dns_cname', 'This method is deprecated please use the namspaced version dnsquery::cname')
    call_function('dnsquery::cname', record)
  end

  def dns_cname_with_default(record)
    dns_cname(record)
  rescue Resolv::ResolvError
    yield
  end
end
