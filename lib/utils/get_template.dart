enum Template { getx, provider }

Template getTemplate(String? templateName) {
  switch (templateName?.toLowerCase()) {
    case 'getx':
      return Template.getx;
    case 'provider':
      return Template.provider;
    default:
      return Template.getx;
  }
}
