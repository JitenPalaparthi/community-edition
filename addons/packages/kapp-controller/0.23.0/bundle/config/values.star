load("@ytt:data", "data")
load("@ytt:assert", "assert")

#export
values = data.values
kappNamespace = ""
if hasattr(values.kappController, 'namespace') and values.kappController.namespace:
    kappNamespace = values.kappController.namespace
else:
    kappNamespace = values.namespace
end
