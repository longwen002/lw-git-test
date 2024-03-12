# NTS depends on HI_TEE in customer.mk
HI_NTS := false

ifeq ($(HI_NTS), true)
    #whether support mgk id
    NETFLIX_SUPPORT_MGKID := true

    PRODUCT_PROPERTY_OVERRIDES += \
        ro.vendor.support.nts=true \
        ro.vendor.nrdp.validation=ninja_6 \
        ro.vendor.nrdp.modelgroup=HiJupiter \
        ro.graph.ignore.hdr=false
endif
