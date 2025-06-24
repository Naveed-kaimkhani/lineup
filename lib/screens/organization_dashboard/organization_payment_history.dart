import 'package:flutter/material.dart';
import 'package:gaming_web_app/Base/controller/org_controller/org_payment_controller.dart'
    show OrgPaymentController;
import 'package:get/get.dart';
import 'package:gaming_web_app/Base/controller/org_controller/payment_history_controller.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/Base/model/teamModel/activation_history_model.dart';
import 'package:gaming_web_app/constants/widgets/custom_scaffold/dashboard_scaffold.dart';
import 'package:gaming_web_app/routes/routes_path.dart';
import 'package:intl/intl.dart';

class OrganizationPaymentHistory extends StatelessWidget {
  OrganizationPaymentHistory({super.key});

  final controller = Get.put(OrgPaymentController());

  @override
  Widget build(BuildContext context) {
    controller.fetchHistory();

    return DashboardScaffold(
      onTab: () {
        Get.back();
      },
      isShowBanner: false,
      bg: false,
      userImage: 'assets/images/dummy_image.png',
      userName: 'Test User',
      title: 'Game-Ready',
      subtitle: 'Activation History',
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child:
                isMobile
                    ? ListView.builder(
                      itemCount: controller.history.length,
                      itemBuilder:
                          (context, index) =>
                              _buildMobileCard(controller.history[index]),
                    )
                    : Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeaderRow(),
                              const SizedBox(height: 8),
                              ...controller.history.map(_buildDataRow).toList(),
                            ],
                          ),
                        ),
                      ),
                    ),
          );
        },
      );
    });
  }

  // Widget _buildHeaderRow() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: const Color(0xffE6E6E6),
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  //     child: Row(
  //       children: const [
  //         _TableHeaderCell(title: "Record ID", flex: 1),
  //         _TableHeaderCell(title: "Org Name", flex: 2),
  //         _TableHeaderCell(title: "Org Code", flex: 2),
  //         _TableHeaderCell(title: "Promo Code", flex: 2),
  //         _TableHeaderCell(title: "Activated At", flex: 2),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildHeaderRow() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffE6E6E6),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: const [
          // _TableHeaderCell(title: "Record ID", flex: 1),

          // _TableHeaderCell(title: "Slot ID", flex: 1),
          _TableHeaderCell(title: "Type", flex: 1),

          _TableHeaderCell(title: "Amount/Promo", flex: 2),

          _TableHeaderCell(title: "Status", flex: 2),
          // _TableHeaderCell(title: "Promo", flex: 2),
          _TableHeaderCell(title: "Activated On", flex: 2),

          _TableHeaderCell(title: "Description", flex: 2),
        ],
      ),
    );
  }

  // Widget _buildDataRow(ActivationRecord record) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  //     margin: const EdgeInsets.symmetric(vertical: 6),
  //     decoration: const BoxDecoration(color: Colors.white),
  //     child: Row(
  //       children: [
  //         _TableDataCell(content: record.recordId.toString(), flex: 1),
  //         _TableDataCell(content: record.organizationName, flex: 2),
  //         _TableDataCell(content: record.organizationCode, flex: 2),
  //         _TableDataCell(content: record.promoCode ?? "", flex: 2),
  //         _TableDataCell(content: record.activatedAt, flex: 2),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildDataRow(ActivationRecord record) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          // _TableDataCell(content: record.recordId.toString(), flex: 1),

          // _TableDataCell(content: record.slotId.toString(), flex: 1),
          _TableDataCell(content: record.type, flex: 1),
          // _TableDataCell(content: record.amountDisplay ?? "-", flex: 2),
          _TableDataCell(
            content:
                (record.promoCode != null && record.promoCode!.isNotEmpty)
                    ? record.promoCode!
                    : (record.amountDisplay ?? "-"),
            flex: 2,
          ),

          _TableDataCell(content: record.status ?? "-", flex: 2),

          // _TableDataCell(content: record.promoCode ?? "-", flex: 2),
          _TableDataCell(content: _formatDate(record.activatedAt), flex: 2),

          _TableDataCell(content: record.description ?? "-", flex: 2),
          // _buildMobileItem("Activated On", _formatDate(record.activatedAt)),
        ],
      ),
    );
  }

  // Widget _buildMobileCard(ActivationRecord record) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(vertical: 8),
  //     padding: const EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       border: Border.all(color: AppColors.primaryColor.withOpacity(0.2)),
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         _buildMobileItem("Record ID", record.recordId.toString()),
  //         _buildMobileItem("Org Name", record.organizationName),
  //         _buildMobileItem("Org Code", record.organizationCode),
  //         _buildMobileItem("Promo Code", record.promoCode ?? ""),
  //         _buildMobileItem("Activated At", record.activatedAt),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildMobileCard(ActivationRecord record) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _buildMobileItem("Record ID", record.recordId.toString()),

          // _buildMobileItem("Slot ID", record.slotId.toString()),
          _buildMobileItem("Type", record.type),
          _buildMobileItem("Amount", record.amountDisplay ?? "-"),

          _buildMobileItem("Promo", record.promoCode ?? "-"),

          // _buildMobileItem("Activated On", record.activatedAt),
          _buildMobileItem("Status", record.status ?? "-"),
          _buildMobileItem("Activated On", _formatDate(record.activatedAt)),
          _buildMobileItem("Description", record.description ?? "-"),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final dateTime = DateTime.parse(dateStr);
      return DateFormat('d-M-yyyy').format(dateTime.toLocal());
    } catch (e) {
      return dateStr; // fallback if parsing fails
    }
  }

  // String _formatDate(String dateStr) {
  //   try {
  //     final dateTime = DateTime.parse(dateStr);
  //     return DateFormat('MMM dd, yyyy — hh:mm a').format(dateTime.toLocal());
  //   } catch (e) {
  //     return dateStr; // fallback to original if parsing fails
  //   }
  // }

  Widget _buildMobileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: tableLabel.copyWith(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              value,
              style: fieldLabelStyle.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}

class _TableHeaderCell extends StatelessWidget {
  final String title;
  final int flex;

  const _TableHeaderCell({required this.title, required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        title,
        style: tableLabel.copyWith(color: AppColors.primaryColor, fontSize: 14),
      ),
    );
  }
}

class _TableDataCell extends StatelessWidget {
  final String content;
  final int flex;

  const _TableDataCell({required this.content, required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        content,
        style: fieldLabelStyle.copyWith(
          color: AppColors.descriptiveTextColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
