curl https://raw.githubusercontent.com/KhronosGroup/OpenGL-Registry/784b8b340e0429da3be2378bd5217d3c5530b9e5/xml/gl.xml > generated/gl.xml

# phosphorus expects one API, but we're trying to generate bindings for multiple at once.
# We'll work around it for now by renaming GL ES 3.2 to match GL 4.6.
replacements=''
replacements+='s/api="gles2"/api="gl"/g;'
replacements+='s/name="GL_ES_VERSION_3_2"/name="GL_VERSION_4_6"/g;'
replacements+='s/number="3.2"/number="4.6"/g;'
replacements+='s/<kinds>\(.*\)/<!--removed_kinds_for_phosphorus-->/g;'
replacements+='s/<kind\(.*\)/<!--removed_kind-->/g;'
replacements+='s/<\/kinds>\(.*\)/<!--removed_kinds_for_phosphorus-->/g;'
replacements+='s/kind="\(.*\)"//g;'
sed --in-place $replacements generated/gl.xml

phosphorus \
    --xml ./generated/gl.xml \
    --api gl \
    --name GL_VERSION_4_6 \
    --number 4.6 \
--ext GL_ARB_debug_output \
--ext GL_KHR_debug \
--ext GL_ARB_texture_filter_anisotropic \
--ext GL_EXT_texture_filter_anisotropic \
--ext GL_ARB_tessellation_shader \
--ext GL_ARB_compute_shader \
--ext GL_ARB_instanced_arrays \
--ext GL_EXT_draw_buffers2 \
--ext GL_ARB_draw_instanced \
--ext GL_ARB_base_instance \
--ext GL_ARB_draw_elements_base_vertex \
--ext GL_ARB_framebuffer_sRGB \
--ext GL_ARB_uniform_buffer_object \
--ext GL_ARB_copy_buffer \
--ext GL_NV_copy_buffer \
--ext GL_ARB_sampler_objects \
--ext GL_ARB_buffer_storage \
--ext GL_EXT_buffer_storage \
--ext GL_ARB_vertex_array_object \
--ext GL_ARB_framebuffer_object \
--ext GL_ARB_texture_storage \
--ext GL_ARB_program_interface_query \
--ext GL_ARB_sync \
--ext GL_KHR_parallel_shader_compile \
--ext GL_ARB_parallel_shader_compile\
> generated/gl46.rs

sed --in-place 's/^type/pub(crate) type/g;s/static\ gl/pub static\ gl/g;' generated/gl46.rs

cp generated/gl46.rs src/gl46.rs
