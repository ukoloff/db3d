module AuthHelper
  Providers = Hash[YAML.load(<<-EOY)
    Google:
    GitHub:
    Facebook:
    Twitter:
    Яндекс:
      yahoo: yandex
    ВКонтакте:
      vk: vkontakte
  EOY
  .map do |k, v|

    v = k.downcase unless v
    v = Hash===v ? v.first : [v, v]
    [v[1], {title: k, icon: v[0]}]
  end]
end
