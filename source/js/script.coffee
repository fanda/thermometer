#= require dynamic

window.Home = Ractive.extend({
  template: "#HomeT"
})

window.Status = Ractive.extend({
  template: "#StatusT"
})


window.MainOptions = Ractive.extend({
  template: "#MainOptionsT"
})

window.EmailOptions = Ractive.extend({
  template: "#EmailOptionsT"
})

window.SmsOptions = Ractive.extend({
  template: "#SmsOptionsT"
})

window.DeviceOptions = Ractive.extend({
  template: "#DeviceOptionsT"
})

window.NetworkOptions = Ractive.extend({
  template: "#NetworkOptionsT"
})

window.Settings = Ractive.extend({
  template: "#SettingsT"
  components:
    main: MainOptions
    email: EmailOptions
    sms: SmsOptions
    device: DeviceOptions
    network: NetworkOptions

  data:
    settings_form: "main"
    settings_menu:
      main:
        active: true
        title: "Obecná nastavení"
      email:
        title: "Upozornění e-mailem"
      sms:
        title: "Upozornění přes sms"
      network:
        title: "Síťové připojení"
      device:
        title: "Zařízení"

  onrender: () ->
    self = this

    @on "subgo", (ev, target) ->
      ev.original.preventDefault()
      self.set("settings_form", target)
      self.set("settings_menu.*.active", false)
      self.set("settings_menu."+target+".active", true)
      return false

})
window.Locale = Ractive.extend({
  template: "#LocaleT"
  oninit: () ->
    @observe('lang', (nv, ov) ->
      @set('l_value', @get('locales.'+ @get('lang')+'.'+@get('l_key')))
    )
})
window.Translations = Ractive.extend({
  template: "#TranslationsT"
  data:
    lang1: "cz"
    lang2: "en"
    locales: {
      cz:
        status: "Stav"
        home: "Stav"
        device: "Zařízení"
        settings: "Nastavení"
      en:
        status: "Status"
        home: "Home"
        device: "Device"
        settings: "Settings"
    }
  components:
    locale: Locale
})


window.Thermo = new Ractive({
  template: "#ThermoT"
  el: "#Thermo"
  components:
    settings: Settings
    translations: Translations
    status: Status
    home: Home
    network: NetworkOptions
    device: DeviceOptions

  data:
    active_page: "home"
    menu: [
      {
        title: "Stav"
        href: "home"
      }
      {
        title: "Zařízení"
        href: "device"
      }
      {
        title: "Nastavení"
        href: "settings"
      }
      {
        title: "Překlady"
        href: "translations"
      }
    ]
    sensors: [
      {
        name: "Čidlo 1"
        email: "xx@yy.zz"
      }
      {
        name: "Čidlo 2"
        email: "xx@yy.zz"
      }
    ]

    languages:
      cz: "Čeština"
      en: "English"
    language: "cz"
    l:
      status: "Stav"
      home: "Stav"
      device: "Zařízení"
      settings: "Nastavení"

  computed:
    l_keys: () ->
      Object.keys(@get('l'))

  onrender: () ->
    self = this

    @on "go", (ev, target) ->
      ev.original.preventDefault()
      self.set("active_page", target)
      return false



})
