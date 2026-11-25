CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Header RESULT result.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Header RESULT result.

    METHODS downloadPicklist FOR MODIFY
      IMPORTING keys FOR ACTION Header~downloadPicklist RESULT result.

    " Standard RAP unmanaged contract methods to prevent SADL dump
    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Header.

    METHODS read FOR READ
      IMPORTING keys FOR READ Header RESULT result.
ENDCLASS.

CLASS lhc_Header IMPLEMENTATION.

  METHOD get_global_authorizations.
    IF requested_authorizations-%action-downloadPicklist = if_abap_behv=>mk-on.
      result-%action-downloadPicklist = if_abap_behv=>auth-allowed.
    ENDIF.
  ENDMETHOD.

  METHOD get_instance_features.
    result = VALUE #( FOR ls_key IN keys
                      ( %tky = ls_key-%tky
                        %action-downloadPicklist = if_abap_behv=>fc-o-enabled ) ).
  ENDMETHOD.

  METHOD downloadPicklist.
    DATA: lt_pdf_binaries TYPE STANDARD TABLE OF xstring WITH EMPTY KEY,
          lv_merged_pdf   TYPE xstring.

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_key>).
      TRY.
          " Point directly to the dedicated Picklist FDP service
          DATA(lo_fdp) = cl_fp_fdp_services=>get_instance( iv_service_definition = 'ZSD_PICK_FDP_SRV' ).

          " Fetch exact key structure to prevent TYPE_NOT_FOUND dump
          DATA(lt_fdp_keys) = lo_fdp->get_keys( ).

          " Map current row keys (Sales Order)
          lt_fdp_keys[ name = 'SALESORDER' ]-value = <fs_key>-SalesOrder.

          " Use read_to_xml_v2 with the fully typed keys
          DATA(lv_xml_data) = lo_fdp->read_to_xml_v2(
            it_select = lt_fdp_keys
          ).

          DATA(lo_form_reader) = cl_fp_form_reader=>create_form_reader( 'ZSD_PICK_FORM' ).
          DATA(lv_xdp_layout)  = lo_form_reader->get_layout( ).

          cl_fp_ads_util=>render_pdf(
            EXPORTING
              iv_xml_data   = lv_xml_data
              iv_xdp_layout = lv_xdp_layout
              iv_locale     = 'en_US'
            IMPORTING
              ev_pdf        = DATA(lv_single_pdf)
          ).

          IF lv_single_pdf IS NOT INITIAL.
            APPEND lv_single_pdf TO lt_pdf_binaries.
          ENDIF.

        CATCH cx_fp_fdp_error cx_fp_ads_util cx_fp_form_reader INTO DATA(lx_fp_error).
          " Force the backend error text into a dummy result so the frontend displays it
          result = VALUE #( ( %tky   = keys[ 1 ]-%tky
                              %param = VALUE #( MimeType = 'error'
                                                FileName = lx_fp_error->get_text( )
                                                PdfFile  = 'ERROR' ) ) ).
          RETURN.
      ENDTRY.
    ENDLOOP.

    IF lt_pdf_binaries IS INITIAL.
      RETURN.
    ENDIF.

    DATA(lo_merger) = cl_rspo_pdf_merger=>create_instance( ).
    LOOP AT lt_pdf_binaries INTO DATA(lv_single_bin).
      lo_merger->add_document( lv_single_bin ).
    ENDLOOP.

    TRY.
        lv_merged_pdf = lo_merger->merge_documents( ).
      CATCH cx_rspo_pdf_merger INTO DATA(lx_merge).
        APPEND VALUE #( %tky = keys[ 1 ]-%tky ) TO failed-header.
        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                        %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                      text     = 'PDF Merge Failed' ) ) TO reported-header.
        RETURN.
    ENDTRY.

    DATA(lv_base64_pdf) = cl_web_http_utility=>encode_x_base64( lv_merged_pdf ).

    result = VALUE #( FOR ls_key IN keys
                      ( %tky   = ls_key-%tky
                        %param = VALUE #( MimeType = 'application/pdf'
                                          FileName = 'Merged_Picklist.pdf'
                                          PdfFile  = lv_base64_pdf ) ) ).
  ENDMETHOD.

  METHOD lock.
    " Left empty to fulfill unmanaged read-only contract
  ENDMETHOD.

  METHOD read.
    " Left empty to fulfill unmanaged read-only contract
  ENDMETHOD.

ENDCLASS.

" ====================================================================
" Unmanaged Contract Stubs for Child and Saver Layers
" ====================================================================

CLASS lhc_Item DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS read FOR READ
      IMPORTING keys FOR READ Item RESULT result.

    METHODS rba_Header FOR READ
      IMPORTING keys_rba FOR READ Item\_Header FULL result_requested RESULT result LINK association_links.
ENDCLASS.

CLASS lhc_Item IMPLEMENTATION.
  METHOD read.
  ENDMETHOD.
  METHOD rba_Header.
  ENDMETHOD.
ENDCLASS.

CLASS lsc_ZSD_PICK_I_HDR DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS finalize REDEFINITION.
    METHODS check_before_save REDEFINITION.
    METHODS save REDEFINITION.
    METHODS cleanup REDEFINITION.
    METHODS cleanup_finalize REDEFINITION.
ENDCLASS.

CLASS lsc_ZSD_PICK_I_HDR IMPLEMENTATION.
  METHOD finalize.
  ENDMETHOD.
  METHOD check_before_save.
  ENDMETHOD.
  METHOD save.
  ENDMETHOD.
  METHOD cleanup.
  ENDMETHOD.
  METHOD cleanup_finalize.
  ENDMETHOD.
ENDCLASS.
