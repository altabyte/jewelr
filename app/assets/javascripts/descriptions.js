/**
 * This javascript needs access to the gon.materials variable which is defined
 * in the page head. But TurboLinks does not reload the page, so gon.materials
 * is not accessible. To solve this, links to the description edit page must
 * disable TurboLinks:
 *
 * <%= link_to('Edit', sti_description_path(description.type, description.id, :edit), data: { no_turbolink: true }) %>
 *                                                                                    ----------------------------
 * Consider using the jquery.turbolinks gem?
 *   https://github.com/kossnocorp/jquery.turbolinks
 */
$(document).on("ready page:load", function () {

    if ($("#descriptions #new, #descriptions #edit").length) {

        function nestedModelIdAndName(nestedModel, index, field, subField) {
            return 'id="' + nestedModelID(nestedModel, index, field, subField) +
                '" name="' + nestedModelName(nestedModel, index, field) + '"';
        }

        function nestedModelID(nestedModel, index, field, subField) {
            var id = '' + gon.description_type + '_' + nestedModel.toLowerCase() + 's_attributes' + '_' + index + '_' + field;
            if (subField !== undefined) {
                id += '_' + subField;
            }
            return id;
        }

        function nestedModelName(nestedModel, index, field) {
            return '' + gon.description_type + '[' + nestedModel.toLowerCase() + 's_attributes' + '][' + index + '][' + field + ']';
        }

        //--------------------------------------------------------------------
        if ($("#colours").length) {

            $('#colours-list .colour').append(function () {
                var id  = $(this).data('id');
                var hex =  $(this).data('hex').toString().toUpperCase();
                var string = '<input type="text" class="kolorPicker" value="' + hex + '" ' + 'style="color: #' + hex + '; background-color: #' + hex + ';"' + nestedModelIdAndName('Colour', id, 'hex') + '>';
                string += '<input type="hidden" value="' + id + '" ' + nestedModelIdAndName('Colour', id, 'id') + '>';
                return string;
            });

            function addColourInputHandler() {
                var newColourHTML =
                    '<li class="colour" style="display: none;">' +
                    '<input type="text" class="kolorPicker"' +
                    nestedModelIdAndName('Colour', Date.now(), 'hex') +
                    '>' +
                    '</li>';

                $(newColourHTML).appendTo("#colours-list").show('fast');
            }

            $('#add-colour-button').click(function () {
                addColourInputHandler();
            });
        }

        //--------------------------------------------------------------------
        if ($("#ingredients").length) {

            var locale = gon.locale !== undefined ? gon.locale : 'en';
            var ingredientsCount = 0;

            function reindexIngredientPositions() {
                $('#ingredients-list .ingredient').each(function (index) {
                    $(this).find('.position').val(index + 1);
                });
            }

            function addMaterialEventHandler() {
                reindexIngredientPositions();
                var ingredient_id = null;
                var material_id = $('#add-ingredient-button').data().material_id;
                var materialNameEN = $('#add-ingredient-button').data().material_name_en;
                var materialNameZH = $('#add-ingredient-button').data().material_name_zh;
                var position = $('#ingredients-list li').length + 1;
                var genuine = true;
                var significance = 'primary';

                if (material_id === undefined) {
                    return;
                }

                var materialIncluded = false;
                $('#ingredients-list .ingredient').each(function () {
                    if ($(this).data('material-id') == material_id) {
                        materialIncluded = true;
                    }
                });
                if (materialIncluded) {
                    alert((locale == 'zh' ? materialNameZH : materialNameEN) + " is already included!");
                    $("#add-ingredient-button").removeData('material_id');
                    $('#material-name-input').val('');
                    return;
                }

                ingredientsCount += 1;

                var materialName = (locale == 'zh' ? materialNameZH : materialNameEN);
                if (materialName == null) materialName = materialNameEN;

                var newMaterialHTML = '<li class="ingredient" data-material-id="' + material_id + '" style="display: none;">' + getIngredientFields(ingredient_id, material_id, materialName, position, genuine, significance) + '</li>';
                $(newMaterialHTML).appendTo("#ingredients-list")
                    .show('slow')
                    .find('.significance').buttonset().end()
                    .find('.destroy').click(function () {
                        $(this).closest('li').hide('slow', function () {
                            $(this).closest('li').remove();
                        });
                        reindexIngredientPositions();
                    });

                $("#add-ingredient-button").removeData('material_id');
                $('#material-name-input').val('');
            }

            function getIngredientFields(ingredient_id, material_id, material_name, position, genuine, significance) {
                var renderLabelForGenuine = false;

                var string = '<div class="handle">' + material_name + '</div>';
                if (ingredient_id != null) {
                    string += '<input type="hidden" ' + nestedModelIdAndName('Ingredient', material_id, 'id') + ' value="' + ingredient_id + '">';
                }

                string += '<input type="hidden" ' + nestedModelIdAndName('Ingredient', material_id, 'material_id') + ' value="' + material_id + '">';
                string += '<input type="hidden" ' + nestedModelIdAndName('Ingredient', material_id, 'position') + ' value="' + position + '" class="position" >';

                string += '<div class="significance">';
                string += '<input type="radio" ' + nestedModelIdAndName('Ingredient', material_id, 'significance', 'primary') + ' value="primary"' + (significance == 'primary' ? ' checked="checked"' : '') + '>';
                string += '<label for="' + nestedModelID('Ingredient', material_id, 'significance', 'primary') + '">P</label>';
                string += '<input type="radio" ' + nestedModelIdAndName('Ingredient', material_id, 'significance', 'secondary') + ' value="secondary"' + (significance == 'secondary' ? ' checked="checked"' : '') + '>';
                string += '<label for="' + nestedModelID('Ingredient', material_id, 'significance', 'secondary') + '">S</label>';
                string += '<input type="radio" ' + nestedModelIdAndName('Ingredient', material_id, 'significance', 'tertiary') + ' value="tertiary"' + (significance == 'tertiary' ? ' checked="checked"' : '') + '>';
                string += '<label for="' + nestedModelID('Ingredient', material_id, 'significance', 'tertiary') + '">T</label>';
                string += '</div>';

                var genuineChecked = (genuine == true ? 'checked="checked"' : '');
                string += '<input type="checkbox" ' + nestedModelIdAndName('Ingredient', material_id, 'genuine') + ' value="1" ' + genuineChecked + ' class="genuine">';
                if (renderLabelForGenuine) {
                    string += '<label for="' + nestedModelID('Ingredient', material_id, 'genuine') + '" class="genuine">Genuine</label>';
                }

                string += '<span class="destroy" data-material-id="' + material_id + '">&times;</span>';
                return string;
            }


            ingredientsCount = $('#ingredients').data().count;
            $('#ingredients-legend').html(locale == 'zh' ? "材料" : 'Materials');
            $('#add-ingredient-button').html(locale == 'zh' ? "添加" : 'Add');

            /* Set the autocomplete label based upon the page locale */
            if (typeof gon.materials !== 'undefined') {
                for (var i = 0; i < gon.materials.length; ++i) {
                    gon.materials[i].label = (locale == 'zh' ? gon.materials[i].pinyin : gon.materials[i].en);
                }
            }
            else {
                $('#alert').append("<p>List of materials is not available!</p>");
            }


            $("#material-name-input").autocomplete({
                minLength: 0,
                source: gon.materials,
                focus: function (event, ui) {
                    var displayValue = locale == 'zh' ? ui.item.zh : ui.item.en;
                    if (displayValue == null) displayValue = ui.item.en;
                    $("#material-name-input").val(displayValue);
                    return false;
                },
                change: function (event, ui) {
                    if (!ui.item) {
                        $("#material-name-input").val("");
                        $("#material-add-button").data('disabled', 'true');
                    }
                    return false;
                },
                select: function (event, ui) {
                    var displayValue = locale == 'zh' ? ui.item.zh : ui.item.en;
                    if (displayValue == null) displayValue = ui.item.en;
                    $("#material-name-input").val(displayValue);
                    $("#add-ingredient-button").data('material_id', ui.item.value);
                    $("#add-ingredient-button").data('material_name_en', ui.item.en);
                    $("#add-ingredient-button").data('material_name_zh', ui.item.zh);
                    return false;
                }
            }).autocomplete("instance")._renderItem = function (ul, item) {
                var displayValue = locale == 'zh' ? item.zh : item.en;
                if (displayValue == null) displayValue = item.en;
                return $("<li>")
                    .append("<a>" + (displayValue) + "</a>")
                    .appendTo(ul);
            };

            $("#material-name-input").keypress(function (event) {
                if (event.which == 13) {
                    event.preventDefault();
                    addMaterialEventHandler();
                }
            });

            $('#add-ingredient-button').click(function () {
                addMaterialEventHandler();
            });

            $('#ingredients-list').sortable({
                axis: 'y',
                dropOnEmpty: false,
                handle: '.handle',
                cursor: 'move',
                opacity: 0.4,
                scroll: true,
                scrollSpeed: 3,
                scrollSensitivity: 80,
                update: function () {
                    $('#ingredients-list .ingredient').each(function (index) {
                        $(this).find('.position').val(index + 1);
                    });
                }
            });

            $('#ingredients-list .ingredient')
                .append(function () {
                    var ingredient_id = $(this).data('id');
                    var material_id = $(this).data('material-id');
                    var material_name = (locale == 'zh' ? $(this).data('material-name-zh') : $(this).data('material-name-en'));
                    var position = $(this).data('position');
                    var genuine = $(this).data('genuine');
                    var significance = $(this).data('significance');

                    var string = getIngredientFields(ingredient_id, material_id, material_name, position, genuine, significance);
                    return string;
                })
                .find('.significance').buttonset().end()
                .find('.destroy').click(function () {
                    var material_id = $(this).closest('li').data('material-id');
                    $(this).closest('li').hide('slow', function () {
                        $(this).closest('li').append('<input type="hidden" ' + nestedModelIdAndName('Ingredient', material_id, '_destroy') + ' value="' + 1 + '">');
                    });
                });
        }
    }
});
