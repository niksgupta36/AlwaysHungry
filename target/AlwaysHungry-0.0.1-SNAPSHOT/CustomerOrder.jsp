
<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Order</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css" integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B" crossorigin="anonymous">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <link href="FL.css" rel="stylesheet">
 
</head>

<body>

    <form class="form-signin"  action="CustomerOrder" method="post" style="padding: 40px;">

        <div class="text-center">
            <h1 class="h2 font-weight-normal">Place an Order</h1>
        </div>

      <br>

        <div class="row">
            <div class="col-md-4 col-sm-4 col-12">
                <h4>Burger</h4>
            </div>
            <div class="col-md-2 col-sm-2 col-2">

                <span class="input-group-btn"> 
                    <button tabindex="-1" type="button" class="btn btn-default btn-number" disabled="disabled" data-type="minus" data-field="quant[1]"> 
                        <span> - </span>
                </button>
                </span>

            </div>

            <div class="col-md-4 col-sm-4 col-4">
                <input id="Select1" type="text" name="quant[1]" class="form-control input-number" value="0" min="0" max="999">
            </div>
            <div class="col-md-2 col-sm-2 col-2">
                <span class="input-group-btn"> 
                <button tabindex="-1" type="button" class="btn btn-default btn-number" data-type="plus" data-field="quant[1]">
                    <span> + </span>
                </button>
                </span>
            </div>
        </div>

        <div class="row">
            <div class="col-md-4 col-sm-4 col-12">
                <h4>Fries</h4>
            </div>
            <div class="col-md-2 col-sm-2 col-2">

                <span class="input-group-btn"> 
                    <button tabindex="-1" type="button" class="btn btn-default btn-number" disabled="disabled" data-type="minus" data-field="quant[2]"> 
                        <span>-</span>
                </button>
                </span>
            </div>
            <div class="col-md-4 col-sm-4 col-4">
                <input id="Select2" type="text" name="quant[2]" class="form-control input-number" value="0" min="0" max="999">
            </div>
            <div class="col-md-2 col-sm-2 col-2">
                <span class="input-group-btn"> 
                <button tabindex="-1" type="button" class="btn btn-default btn-number" data-type="plus" data-field="quant[2]">
                    <span>+</span>
                </button>
                </span>
            </div>
        </div>

        <div class="row">
            <div class="col-md-4 col-sm-4 col-12">
                <h4>Milkshake</h4>
            </div>
            <div class="col-md-2 col-sm-2 col-2">

                <span class="input-group-btn"> 
                    <button tabindex="-1" type="button" class="btn btn-default btn-number" disabled="disabled" data-type="minus" data-field="quant[3]"> 
                        <span>-</span>
                </button>
                </span>
            </div>
            <div class="col-md-4 col-sm-4 col-4">
                <input id="Select3" type="text" name="quant[3]" class="form-control input-number" value="0" min="0" max="999">
            </div>
            <div class="col-md-2 col-sm-2 col-2">
                <span class="input-group-btn"> 
                <button tabindex="-1" type="button" class="btn btn-default btn-number" data-type="plus" data-field="quant[3]">
                    <span>+</span>
                </button>
                </span>
            </div>
        </div> <br>

        <div class="form-group row">
            <label for="inputPassword3" class="col-sm-2 col-form-label">Payment</label>
            <div class="col-sm-6">
                <select class="custom-select mr-sm-2" id="paymentSelector">
                        <option selected>Select option...</option>
                        <option value="1">Pay in store</option>
                        <option value="2">MASTERCARD ****5555</option>
                        <option value="3">VISA ****1111</option>
                    </select>
            </div>
        </div>



        <br>
		
		<form action="CustomerOrder" method="post">
	 <button type="submit" class="btn btn-primary" >Submit Order</button>
	</form>
       
        

    </form>

    <script type="text/javascript">
       

        function checkIfFieldsAreComplete() {

            var paymentMethod = document.getElementById("paymentSelector");
            var S1 = document.getElementById("Select1");
            var S2 = document.getElementById("Select2");
            var S3 = document.getElementById("Select3");

         

            if (S1.value <= 0 && S2.value <= 0 && S3.value <= 0) {
                return "Order must contain at least 1 item"
            }

            if (paymentMethod.selectedIndex == 0) {
                return "Please select a payment method"
            }

            return ""
        }

        function didClickSubmitOrderButton() {

            var validationStr = checkIfFieldsAreComplete()
            if (validationStr != "") {
                alert(validationStr)
                return
            }
            showLoader()
            var reader = new FileReader();
            var file = document.getElementById("avatar").files[0];
            reader.onload = function() {
                var resultData = this.result;
                resultData = resultData.split(',')[1];
                processImage(resultData);
            };
            reader.readAsDataURL(file);
            processImage = function(binaryImage) {
                $.ajax({
                    url: baseURL + "?" + $.param(params),
                    method: "POST",
                    type: "POST",
                    beforeSend: function(xhrObj) {
                        xhrObj.setRequestHeader("Ocp-Apim-Subscription-Key", subKey);
                    },
                    contentType: "application/octet-stream",
                    mime: "application/octet-stream",
                    data: makeblob(binaryImage, 'image/jpeg'),
                    cache: false,
                    processData: false
                }).done(function(data) {
                    createOrderWithFaceID(data[0]["faceId"])
                }).fail(function(err) {
                    hideLoader()
                    alert(JSON.stringify(err))
                });
            }
        }


        function didCreateOrder(orderID) {
            alert("Order Successfully Submitted.\nYour Order Number is " + orderID)
            var shouldRefresh = confirm("Would you like to place another order?")
            if (shouldRefresh) {
                window.location.reload();
            } else if (guestMode) {
                formSubmit("../index.html", {})
            } else {
                formSubmit("home.html", {})
            }
        }

        function getDetailsOfOrder() {

            var S1 = document.getElementById("Select1");
            var S2 = document.getElementById("Select2");
            var S3 = document.getElementById("Select3");

            var textToReturn = ""

            if (S1.value > 0) {
                textToReturn += S1.value + " Burgers"
            }

            if (S2.value > 0) {
                if (textToReturn != "") {
                    textToReturn += "\n"
                }
                textToReturn += S2.value + " Fries"
            }

            if (S3.value > 0) {
                if (textToReturn != "") {
                    textToReturn += "\n"
                }
                textToReturn += S3.value + " Milkshakes"
            }

            return textToReturn
        }
    </script>

    <script type="text/javascript">
        function didClickEditPhoto() {
            document.getElementById("avatar").click()
        }

        var userID = window.sessionStorage.getItem("id")
        var guestMode = false;

     

        $(document).ready(function() {

            $('.btn-number').click(function(e) {
                e.preventDefault();

                fieldName = $(this).attr('data-field');
                type = $(this).attr('data-type');
                var input = $("input[name='" + fieldName + "']");
                var currentVal = parseInt(input.val());
                if (!isNaN(currentVal)) {
                    if (type == 'minus') {

                        if (currentVal > input.attr('min')) {
                            input.val(currentVal - 1).change();
                        }
                        if (parseInt(input.val()) == input.attr('min')) {
                            $(this).attr('disabled', true);
                        }

                    } else if (type == 'plus') {

                        if (currentVal < input.attr('max')) {
                            input.val(currentVal + 1).change();
                        }
                        if (parseInt(input.val()) == input.attr('max')) {
                            $(this).attr('disabled', true);
                        }

                    }
                } else {
                    input.val(0);
                }
            });

            $('.input-number').focusin(function() {
                $(this).data('oldValue', $(this).val());
            });

            $('.input-number').change(function() {

                minValue = parseInt($(this).attr('min'));
                maxValue = parseInt($(this).attr('max'));
                valueCurrent = parseInt($(this).val());

                name = $(this).attr('name');
                if (valueCurrent >= minValue) {
                    $(".btn-number[data-type='minus'][data-field='" + name + "']").removeAttr('disabled')
                } else {
                    $(this).val($(this).data('oldValue'));
                }
                if (valueCurrent <= maxValue) {
                    $(".btn-number[data-type='plus'][data-field='" + name + "']").removeAttr('disabled')
                } else {
                    $(this).val($(this).data('oldValue'));
                }


            });

            $(".input-number").keydown(function(e) {
                // Allow: backspace, delete, tab, escape, enter and .
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 190]) !== -1 ||
                    // Allow: Ctrl+A
                    (e.keyCode == 65 && e.ctrlKey === true) ||
                    // Allow: home, end, left, right
                    (e.keyCode >= 35 && e.keyCode <= 39)) {
                    // let it happen, don't do anything
                    return;
                }
                // Ensure that it is a number and stop the keypress
                if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                    e.preventDefault();
                }
            });

            guestMode = (userID == null);

            if (userID != null) {
                Backendless.Data.of("Users").findById(userID)
                    .then(function(result) {
                    
                    }).catch(function(error) {
                        if (error.code == 1000) {
                            alert("Signed in user not found")
                        } else {
                            alert(JSON.stringify(error))
                        }

                    });
            }


        })
    </script>


    <div id="Loader" class="fadeMe hidden">
        <div class="h-100 row align-items-center">
            <div class="loader mx-auto"></div>
        </div>
    </div>

    <script>
        function showLoader() {
            showElement("Loader")
        }

        function hideLoader() {
            hideElement("Loader")
        }

        function hideElement(id) {
            document.getElementById(id).style.display = "none";
        }

        function showElement(id) {
            document.getElementById(id).style.display = "block";
        }
    </script>

</body>

</html>

<style>
    .profile-header-container {
        margin: 0 auto;
        text-align: center;
    }

    .profile-header-img {
        padding: 16px;
    }

    .profile-header-img>img.img-circle {
        width: 120px;
        height: 120px;
        border: 2px solid #51D2B7;
    }

    .profile-header {
        margin-top: 43px;
    }

    /**
 * Ranking component
 */

    .rank-label-container {
        margin-top: -19px;
        /* z-index: 1000; */
        text-align: center;
    }

    .label.label-default.rank-label {
        background-color: rgb(81, 210, 183);
        padding: 5px 10px 5px 10px;
        border-radius: 27px;
    }
</style>



