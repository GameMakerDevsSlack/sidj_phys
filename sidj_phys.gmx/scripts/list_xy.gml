///list_xy(x1,y1,x2,y2..)
var LIST = ds_list_create();
for (var i=0;i<argument_count;i++)
{
    ds_list_add(LIST,argument[i]);
}
return LIST;
