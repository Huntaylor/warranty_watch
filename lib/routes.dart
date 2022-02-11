import 'package:flutter/material.dart';
import 'package:warranty_keeper/presentation/current_warranties/current_warranties_view.dart';
import 'package:warranty_keeper/presentation/home/home_view.dart';
import 'package:warranty_keeper/presentation/new_warranties/presentation/new_warranty_view.dart';
import 'package:warranty_keeper/presentation/warranty_details/presentation/warranty_details_view.dart';

final appRoutes = {
  HomeView.routeName: (BuildContext context) => const HomeView(),
  NewWarrantyView.routeName: (BuildContext context) => const NewWarrantyView(),
  CurrentWarrantiesView.routeName: (BuildContext context) =>
      const CurrentWarrantiesView(),
  WarrantyDetailsView.routeName: (BuildContext context) =>
      const WarrantyDetailsView(),
};
